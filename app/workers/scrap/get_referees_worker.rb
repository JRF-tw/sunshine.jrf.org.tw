class Scrap::GetRefereesWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  recurrence backfill: true do
    daily.hour_of_day(2)
  end

  def perform
    Scrap::GetRefereesContext.delay(retry: false, queue: 'crawler_referee').perform
  end
end
