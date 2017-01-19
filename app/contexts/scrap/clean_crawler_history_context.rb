class Scrap::CleanCrawlerHistoryContext < BaseContext
  class << self
    def perform
      new.perform
    end
  end

  def initialize
    @crawler_histories = CrawlerHistory.where('crawler_on < ?', Time.zone.today - 1.month)
  end

  def perform
    run_callbacks :perform do
      @crawler_histories.destroy_all
    end
  end
end
