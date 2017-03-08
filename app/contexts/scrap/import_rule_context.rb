class Scrap::ImportRuleContext < BaseContext
  include Scrap::Concerns::AnalysisVerdictContent

  before_perform  :find_or_create_story
  before_perform  :create_rule
  before_perform  :create_main_judge_by_highest, if: :is_highest_court?
  before_perform  :assign_names
  after_perform   :update_data_to_story
  after_perform   :upload_file
  after_perform   :record_count_to_daily_notify
  after_perform   :alert_new_story_type

  class << self
    def perform(court, orginal_data, content, word, publish_on, story_type)
      new(court, orginal_data, content, word, publish_on, story_type).perform
    end
  end

  def initialize(court, orginal_data, content, word, publish_on, story_type)
    @court = court
    @orginal_data = orginal_data
    @content = content
    @word = word
    @publish_on = publish_on
    @story_type = story_type
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
  end

  def perform
    run_callbacks :perform do
      add_error('create date fail') unless @rule.save
      @rule
    end
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

  def create_main_judge_by_highest
    parse_judges_names(@rule, @content, @crawler_history).each do |judge|
      Scrap::CreateJudgeByHighestCourtContext.new(@court, judge).perform
    end
  end

  def is_highest_court?
    @court.code == 'TPS'
  end

  def assign_names
    @rule.assign_attributes(
      judges_names: parse_judges_names(@rule, @content, @crawler_history),
      prosecutor_names: parse_prosecutor_names(@rule, @content, @crawler_history),
      lawyer_names: parse_lawyer_names(@rule, @content, @crawler_history),
      party_names: parse_party_names(@rule, @content, @crawler_history)
    )
  end

  def update_data_to_story
    @story.assign_attributes(judges_names: (@story.judges_names + @rule.judges_names).uniq)
    @story.assign_attributes(prosecutor_names: (@story.prosecutor_names + @rule.prosecutor_names).uniq)
    @story.assign_attributes(lawyer_names: (@story.lawyer_names + @rule.lawyer_names).uniq)
    @story.assign_attributes(party_names: (@story.party_names + @rule.party_names).uniq)
    @story.save
  end

  def upload_file
    Scrap::UploadVerdictContext.new(@orginal_data).perform(@rule)
  end

  def record_count_to_daily_notify
    Redis::Counter.new('daily_scrap_rule_count').increment
  end

  def alert_new_story_type
    SlackService.notify_new_story_type_alert("取得新的案件類別 : #{@story_type}") if @story_type.present? && !StoryTypes.list.include?(@story_type)
  end
end
