class Scrap::ImportVerdictContext < BaseContext
  include Scrap::Concerns::AnalysisVerdictContent
  # only import judgment verdict
  DISABLE_RULING = true

  before_perform  :disable_ruling
  before_perform  :find_or_create_story
  before_perform  :create_verdict
  before_perform  :create_main_judge_by_highest, if: :is_highest_court?
  before_perform  :assign_names
  before_perform  :assign_default_value
  after_perform   :upload_file
  after_perform   :update_data_to_story
  after_perform   :update_adjudge_date
  after_perform   :update_pronounce_date
  after_perform   :create_relation_for_lawyer
  after_perform   :create_relation_for_judge
  after_perform   :create_relation_for_party
  after_perform   :calculate_schedule_scores, if: :story_adjudge?
  after_perform   :set_delay_calculate_verdict_scores, if: :story_adjudge?
  after_perform   :record_count_to_daily_notify
  after_perform   :alert_new_story_type
  after_perform   :send_after_verdict_noice

  class << self
    def perform(court, orginal_data, content, word, publish_date, story_type)
      new(court, orginal_data, content, word, publish_date, story_type).perform
    end

    def calculate_verdict_scores(story)
      Story::CalculateVerdictScoresContext.new(story).perform
    end
  end

  def initialize(court, orginal_data, content, word, publish_date, story_type)
    @court = court
    @orginal_data = orginal_data
    @content = content
    @word = word
    @publish_date = publish_date
    @story_type = story_type
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
  end

  def perform
    run_callbacks :perform do
      add_error('create date fail') unless @verdict.save
      @verdict
    end
  end

  private

  def disable_ruling
    return is_judgment? if DISABLE_RULING
  end

  def is_judgment?
    @content.split.first.match(/判決/).present?
  end

  def find_or_create_story
    array = @word.match(/\d+,\W+,\d+/)[0].split(',')
    @story = Story.find_or_create_by(year: array[0], word_type: array[1], number: array[2], court: @court)
  end

  def create_verdict
    @verdict = Verdict.find_or_create_by(
      story: @story,
      publish_date: @publish_date
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

  def assign_default_value
    @verdict.assign_attributes(is_judgment: is_judgment?)
  end

  def upload_file
    Scrap::UploadVerdictContext.new(@orginal_data).perform(@verdict)
  end

  def update_data_to_story
    @story.assign_attributes(judges_names: (@story.judges_names + @verdict.judges_names).uniq)
    @story.assign_attributes(prosecutor_names: (@story.prosecutor_names + @verdict.prosecutor_names).uniq)
    @story.assign_attributes(lawyer_names: (@story.lawyer_names + @verdict.lawyer_names).uniq)
    @story.assign_attributes(party_names: (@story.party_names + @verdict.party_names).uniq)
    @story.assign_attributes(is_adjudge: is_judgment?) if is_judgment?
    @story.assign_attributes(is_pronounce: is_judgment?) if is_judgment? && !@story.is_pronounce
    @story.save
  end

  def update_adjudge_date
    return unless is_judgment?
    @story.update_attributes(adjudge_date: Time.zone.today) unless @story.adjudge_date
    @verdict.update_attributes(adjudge_date: Time.zone.today)
  end

  def update_pronounce_date
    return unless is_judgment?
    @story.update_attributes(pronounce_date: Time.zone.today) unless @story.pronounce_date
  end

  def create_relation_for_lawyer
    @verdict.lawyer_names.each do |name|
      VerdictRelationCreateContext.new(@verdict).perform(name)
      Story::RelationCreateContext.new(@story).perform(name)
    end
  end

  def create_relation_for_judge
    @verdict.judges_names.each do |name|
      VerdictRelationCreateContext.new(@verdict).perform(name)
      Story::RelationCreateContext.new(@story).perform(name)
    end
  end

  def create_relation_for_party
    @verdict.party_names.each do |name|
      VerdictRelationCreateContext.new(@verdict).perform(name)
      Story::RelationCreateContext.new(@story).perform(name)
    end
  end

  def calculate_schedule_scores
    Story::CalculateScheduleScoresContext.new(@story).perform
  end

  def set_delay_calculate_verdict_scores
    self.class.delay_until(3.months.from_now).calculate_verdict_scores(@story)
  end

  def story_adjudge?
    @story.is_adjudge
  end

  def record_count_to_daily_notify
    Redis::Counter.new('daily_scrap_verdict_count').increment
  end

  def alert_new_story_type
    SlackService.notify_new_story_type_alert("取得新的案件類別 : #{@story_type}") if @story_type.present? && !StoryTypes.list.include?(@story_type)
  end

  def send_after_verdict_noice
    Story::AfterVerdictNoticeContext.new(@verdict).perform
  end
end
