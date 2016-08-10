class Scrap::GetSchedulesWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options retry: 3

  recurrence backfill: true do
    daily.hour_of_day(1).minute_of_hour(30)
  end

  def perform
    Scrap::GetSchedulesContext.delay(retry: 3).perform
  end
end
