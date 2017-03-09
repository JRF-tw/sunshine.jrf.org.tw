class Scrap::Concerns::VerdictCommonStep
  include Scrap::Concerns::AnalysisVerdictContent

  def initialize(court:, orginal_data:, content:, word:, publish_on:, story_type:)
    @verdict_type = content.split.first.match(/判決/).present? ? 'verdict' : 'rule'
    @court = court
    @orginal_data = orginal_data
    @content = content
    @word = word
    @publish_on = publish_on
    @story_type = story_type
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
  end

  def before_perform_step
    find_or_create_story
    @verdict = @verdict_type == 'verdict' ? create_verdict : create_rule
    create_main_judge_by_highest if is_highest_court?
    assign_names
    [@verdict, @story]
  end

  def after_perform_step
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
    Rule.find_or_create_by(
      story: @story,
      publish_on: @publish_on
    )
  end

  def create_verdict
    Verdict.find_or_create_by(
      story: @story,
      publish_on: @publish_on
    )
  end

  def create_main_judge_by_highest
    parse_judges_names(@verdict, @content, @crawler_history).each do |judge|
      Scrap::CreateJudgeByHighestCourtContext.new(@court, judge).perform
    end
  end

  def is_highest_court?
    @court.code == 'TPS'
  end

  def assign_names
    @verdict.assign_attributes(
      judges_names: parse_judges_names(@verdict, @content, @crawler_history),
      prosecutor_names: parse_prosecutor_names(@verdict, @content, @crawler_history),
      lawyer_names: parse_lawyer_names(@verdict, @content, @crawler_history),
      party_names: parse_party_names(@verdict, @content, @crawler_history)
    )
  end

  def update_data_to_story
    @story.assign_attributes(judges_names: (@story.judges_names + @verdict.judges_names).uniq)
    @story.assign_attributes(prosecutor_names: (@story.prosecutor_names + @verdict.prosecutor_names).uniq)
    @story.assign_attributes(lawyer_names: (@story.lawyer_names + @verdict.lawyer_names).uniq)
    @story.assign_attributes(party_names: (@story.party_names + @verdict.party_names).uniq)
    @story.save
  end

  def upload_file
    Scrap::UploadVerdictContext.new(@orginal_data).perform(@verdict)
  end

  def record_count_to_daily_notify
    Redis::Counter.new("daily_scrap_#{@verdict_type}_count").increment
  end

  def alert_new_story_type
    SlackService.notify_new_story_type_alert("取得新的案件類別 : #{@story_type}") if @story_type.present? && !StoryTypes.list.include?(@story_type)
  end
end
