class Scrap::UpdateRefereeByFileContext < BaseContext
  include Scrap::AnalysisRefereeContentConcern
  before_perform :get_referee_data
  before_perform :assign_url

  def initialize(referee, url = nil)
    @referee = referee
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
    @target_url = url || reformat_url(@referee.file.url)
  end

  def perform
    run_callbacks :perform do
      @referee.save
    end
  end

  private

  def reformat_url(url)
    protocol = Rails.env.staging? || Rails.env.production? ? 'https:' : 'http:'
    protocol + url
  end

  def get_referee_data
    @response_data = Mechanize.new.get(@target_url)
    @original_data = @response_data.body.force_encoding('UTF-8')
  end

  def assign_url
    @referee.assign_attributes(
      original_url: parse_original_url(@referee, @original_data, @crawler_history),
      stories_history_url: parse_stories_history_url(@referee, @original_data, @crawler_history),
      reason: parse_reason(@referee, @original_data, @crawler_history)
    )
  end
end
