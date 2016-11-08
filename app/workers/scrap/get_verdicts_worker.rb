class Scrap::GetVerdictsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  recurrence backfill: true do
    daily.hour_of_day(2)
  end

  def perform
    Scrap::GetVerdictsContext.delay(retry: false).perform
  end
end
