class Scrap::GetSchedulesWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  recurrence backfill: true do
    daily.hour_of_day(1).minute_of_hour(30)
  end

  def perform
    Scrap::GetSchedulesContext.delay(retry: false).perform
  end
end
