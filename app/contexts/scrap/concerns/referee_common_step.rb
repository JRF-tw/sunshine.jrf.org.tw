module Scrap::Concerns::RefereeCommonStep
  include Scrap::Concerns::AnalysisRefereeContent

  def before_perform_common_step
    find_or_create_story
    @referee = @content.split.first.match(/判決/).present? ? create_verdict : create_rule
    create_main_judge_by_highest if is_highest_court?
    assign_names
  end

  def after_perform_common_step
    update_data_to_story
    upload_file
    record_count_to_daily_notify
    alert_new_story_type
  end

  private

  def find_or_create_story
    array = @word.match(/\d+,\W+,\d+/)[0].split(',')
    @story = Story.find_or_create_by(year: array[0], word_type: array[1], number: array[2], court: @court)
  end

  def create_rule
    @rule = Rule.find_or_create_by(
      story: @story,
      publish_on: @publish_on
    )
  end

  def create_verdict
    @verdict = Verdict.find_or_create_by(
      story: @story,
      publish_on: @publish_on
    )
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

  def update_data_to_story
    @story.assign_attributes(judges_names: (@story.judges_names + @referee.judges_names).uniq)
    @story.assign_attributes(prosecutor_names: (@story.prosecutor_names + @referee.prosecutor_names).uniq)
    @story.assign_attributes(lawyer_names: (@story.lawyer_names + @referee.lawyer_names).uniq)
    @story.assign_attributes(party_names: (@story.party_names + @referee.party_names).uniq)
    @story.save
  end

  def upload_file
    Scrap::UploadRefereeContext.new(@original_data).perform(@referee)
  end

  def record_count_to_daily_notify
    Redis::Counter.new("daily_scrap_#{@referee.class.name.downcase}_count").increment
  end

  def alert_new_story_type
    SlackService.notify_new_story_type_alert("取得新的案件類別 : #{@story_type}") if @story_type.present? && !StoryTypes.list.include?(@story_type)
  end
end
