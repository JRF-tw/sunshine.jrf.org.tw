class Scrap::ImportVerdictContext < BaseContext
  include Scrap::RefereeCommonStepConcern

  before_perform  :before_perform_common_step
  after_perform   :update_adjudged_on
  after_perform   :update_pronounced_on
  after_perform   :after_perform_common_step
  after_perform   :calculate_schedule_scores, if: :story_adjudge?
  after_perform   :send_notice
  after_perform   :send_active_notice

  class << self
    def perform(court, original_data, content, word, adjudged_on, story_type)
      new(court, original_data, content, word, adjudged_on, story_type).perform
    end
  end

  def initialize(court, original_data, content, word, adjudged_on, story_type)
    @court = court
    @original_data = original_data
    @content = content
    @word = word
    @adjudged_on = adjudged_on
    @story_type = story_type
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
  end

  def perform
    run_callbacks :perform do
      unless @verdict.save
        Logs::AddCrawlerError.add_verdict_error(@crawler_history, @verdict, :referee_save_error, @verdict.errors.full_messages.join)
      end
      @verdict
    end
  end

  private

  def update_adjudged_on
    @story.update_attributes(adjudged_on: @adjudged_on, is_adjudged: true) unless @story.adjudged_on
  end

  def update_pronounced_on
    @story.update_attributes(pronounced_on: Time.zone.today, is_pronounced: true) unless @story.pronounced_on
  end

  def calculate_schedule_scores
    Story::CalculateScheduleScoresContext.new(@story).perform
  end

  def story_adjudge?
    @story.is_adjudged
  end

  def send_notice
    Story::AfterVerdictNoticeContext.new(@verdict).perform
  end

  def send_active_notice
    Story::ActiveVerdictNoticeContext.new(@verdict).perform
  end
end
