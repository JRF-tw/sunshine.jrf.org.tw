class Scrap::ImportRuleContext < BaseContext
  include Scrap::Concerns::AnalysisVerdictContent

  before_perform    :run_before_common_step
  after_perform     :run_after_common_step

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
    @common_step = Scrap::Concerns::VerdictCommonStep.new(court: @court,
                                                          original_data: @original_data,
                                                          content: @content,
                                                          word: @word,
                                                          publish_on: @publish_on,
                                                          story_type: @story_type)
  end

  def perform
    run_callbacks :perform do
      add_error('create date fail') unless @rule.save
      @rule
    end
  end

  private

  def run_before_common_step
    @rule, = @common_step.before_perform_step
  end

  def run_after_common_step
    @common_step.after_perform_step
  end
end
