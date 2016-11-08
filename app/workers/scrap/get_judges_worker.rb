class Scrap::GetJudgesWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  recurrence backfill: true do
    daily.hour_of_day(1).minute_of_hour(10)
  end

  def perform
    Scrap::GetJudgesContext.delay(retry: false).perform
  end
end
