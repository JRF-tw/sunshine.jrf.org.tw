class Scrap::GetJudgesWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options retry: 3

  recurrence backfill: true do
    daily.hour_of_day(1).minute_of_hour(10)
  end

  def perform
    Scrap::GetJudgesContext.delay.perform
  end
end
