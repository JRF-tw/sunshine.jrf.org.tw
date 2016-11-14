class Scrap::CleanCrawlerHistoryWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily.hour_of_day(4).minute_of_hour(30)
  end

  def perform
    Scrap::CleanCrawlerHistoryContext.delay.perform
  end
end
