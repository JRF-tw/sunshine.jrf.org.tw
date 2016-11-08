class Scrap::GetCourtsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  recurrence backfill: true do
    weekly.day(:monday).hour_of_day(1)
  end

  def perform
    Scrap::GetCourtsContext.delay(retry: false).perform
  end
end
