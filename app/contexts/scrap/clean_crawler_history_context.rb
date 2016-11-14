class Scrap::CleanCrawlerHistoryContext < BaseContext
  KEEP_INTERVEL = (Time.zone.today - 1.month)..Time.zone.today

  class << self
    def perform
      new.perform
    end
  end

  def initialize
    @crawler_histories = CrawlerHistory.where.not(crawler_on: KEEP_INTERVEL)
  end

  def perform
    run_callbacks :perform do
      @crawler_histories.destroy_all
    end
  end
end
