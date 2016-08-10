class Scrap::GetVerdictsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options retry: 3

  recurrence backfill: true do
    daily.hour_of_day(2)
  end

  def perform
    Scrap::GetVerdictsContext.delay(retry: 3).perform
  end
end
