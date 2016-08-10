class Scrap::GetCourtsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options retry: 3

  recurrence backfill: true do
    weekly.day(:monday).hour_of_day(1)
  end

  def perform
    Scrap::GetCourtsContext.delay(retry: 3).perform
  end
end
