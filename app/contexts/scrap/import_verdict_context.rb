class Scrap::ImportVerdictContext < BaseContext
  include Concerns::Scrap::RefereeCommonStepConcern

  before_perform  :before_perform_common_step
  after_perform   :update_adjudge_date
  after_perform   :update_pronounce_date
  after_perform   :after_perform_common_step
  after_perform   :create_relation_for_role
  after_perform   :calculate_schedule_scores, if: :story_adjudge?
  after_perform   :send_notice
  after_perform   :send_active_notice

  class << self
    def perform(court, original_data, content, word, publish_on, story_type)
      new(court, original_data, content, word, publish_on, story_type).perform
    end
  end

  def initialize(court, original_data, content, word, publish_on, story_type)
    @court = court
    @original_data = original_data
    @content = content
    @word = word
    @publish_on = publish_on
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

  def update_adjudge_date
    @story.update_attributes(adjudge_date: Time.zone.today, is_adjudge: true) unless @story.adjudge_date
    @verdict.update_attributes(adjudge_date: Time.zone.today)
  end

  def update_pronounce_date
    @story.update_attributes(pronounce_date: Time.zone.today, is_pronounce: true) unless @story.pronounce_date
  end

  def create_relation_for_role
    verdict_role_name = @verdict.lawyer_names + @verdict.judges_names + @verdict.party_names + @verdict.prosecutor_names
    verdict_role_name.each do |name|
      VerdictRelationCreateContext.new(@verdict).perform(name)
      Story::RelationCreateContext.new(@story).perform(name)
    end
  end

  def calculate_schedule_scores
    Story::CalculateScheduleScoresContext.new(@story).perform
  end

  def story_adjudge?
    @story.is_adjudge
  end

  def send_notice
    Story::AfterVerdictNoticeContext.new(@verdict).perform
  end

  def send_active_notice
    Story::ActiveVerdictNoticeContext.new(@verdict).perform
  end
end
