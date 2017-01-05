class Scrap::CleanCrawlerHistoryContext < BaseContext
  class << self
    def perform
      new.perform
    end
  end

  def initialize
    @keep_intervel = (Time.zone.today - 1.month)..Time.zone.today
    @crawler_histories = CrawlerHistory.where.not(crawler_on: @keep_intervel)
  end

  def perform
    run_callbacks :perform do
      @crawler_histories.destroy_all
    end
  end
end
