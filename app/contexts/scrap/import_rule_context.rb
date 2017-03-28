class Scrap::ImportRuleContext < BaseContext
  include Scrap::RefereeCommonStepConcern

  before_perform    :before_perform_common_step
  after_perform     :after_perform_common_step

  class << self
    def perform(court, original_data, content, word, adjudge_date, story_type)
      new(court, original_data, content, word, adjudge_date, story_type).perform
    end
  end

  def initialize(court, original_data, content, word, adjudge_date, story_type)
    @court = court
    @original_data = original_data
    @content = content
    @word = word
    @adjudge_date = adjudge_date
    @story_type = story_type
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
  end

  def perform
    run_callbacks :perform do
      unless @rule.save
        Logs::AddCrawlerError.add_rule_error(@crawler_history, @rule, :referee_save_error, @rule.errors.full_messages.join)
      end
      @rule
    end
  end
end
