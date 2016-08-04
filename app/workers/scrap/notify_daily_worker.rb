class Scrap::NotifyDailyWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options retry: 3

  recurrence backfill: true do
    daily.hour_of_day(6)
  end

  def perform
    Scrap::NotifyDailyContext.delay.perform
  end
end
