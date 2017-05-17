module Scrap::RefereeCommonStepConcern
  extend ActiveSupport::Concern

  included do
    include Scrap::AnalysisRefereeContentConcern
  end

  def before_perform_common_step
    find_or_create_story
    @referee = parse_referee_type(@content, @crawler_history) == 'verdict' ? create_verdict : create_rule
    create_main_judge_by_highest if is_highest_court?
    assign_names
    assign_original_url
    assign_stories_history_url
  end

  def after_perform_common_step
    upload_file
    update_data_to_story
    record_count_to_daily_notify
    alert_new_story_type
    create_relation_for_role
  end

  private

  def find_or_create_story
    array = @word.match(/\d+,\W+,\d+/)[0].split(',')
    @story = Story.find_or_create_by(story_type: @story_type, year: array[0], word_type: array[1], number: array[2], court: @court)
  end

  def create_rule
    @rule = Rule.find_or_create_by(
      story: @story,
      adjudged_on: @adjudged_on
    )
  end

  def create_verdict
    @verdict = Verdict.find_or_create_by(story: @story)
    @verdict.assign_attributes(adjudged_on: @adjudged_on)
    @verdict
  end

  def create_main_judge_by_highest
    parse_judges_names(@referee, @content, @crawler_history).each do |judge|
      Scrap::CreateJudgeByHighestCourtContext.new(@court, judge).perform
    end
  end

  def is_highest_court?
    @court.code == 'TPS'
  end

  def assign_names
    @referee.assign_attributes(
      judges_names: parse_judges_names(@referee, @content, @crawler_history),
      prosecutor_names: parse_prosecutor_names(@referee, @content, @crawler_history),
      lawyer_names: parse_lawyer_names(@referee, @content, @crawler_history),
      party_names: parse_party_names(@referee, @content, @crawler_history)
    )
  end

  def assign_original_url
    @referee.assign_attributes(original_url: parse_original_url(@referee, @original_data, @crawler_history))
  end

  def assign_stories_history_url
    @referee.assign_attributes(stories_history_url: parse_stories_history_url(@referee, @original_data, @crawler_history))
  end

  def upload_file
    Scrap::UploadRefereeFileContext.new(@original_data).perform(@referee)
    Scrap::UploadRefereeContentFileContext.new(@original_data).perform(@referee)
  end

  def update_data_to_story
    @story.assign_attributes(reason: @referee.reason) if @referee.reason
    @story.assign_attributes(judges_names: (@story.judges_names + @referee.judges_names).uniq)
    @story.assign_attributes(prosecutor_names: (@story.prosecutor_names + @referee.prosecutor_names).uniq)
    @story.assign_attributes(lawyer_names: (@story.lawyer_names + @referee.lawyer_names).uniq)
    @story.assign_attributes(party_names: (@story.party_names + @referee.party_names).uniq)
    @story.save
  end

  def record_count_to_daily_notify
    Redis::Counter.new("daily_scrap_#{@referee.class.name.downcase}_count").increment
  end

  def alert_new_story_type
    SlackService.notify_new_story_type_alert("取得新的案件類別 : #{@story_type}") if @story_type.present? && !StoryTypes.list.include?(@story_type)
  end

  def create_relation_for_role
    role_name = @referee.lawyer_names + @referee.judges_names + @referee.party_names + @referee.prosecutor_names
    role_name.each do |name|
      RefereeRelationCreateContext.new(@referee).perform(name)
      Story::RelationCreateContext.new(@story).perform(name)
    end
  end
end
