class ConvertExpiredVerdictScoreWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options retry: 3

  recurrence backfill: true do
    daily.hour_of_day(3)
  end

  def perform
    Crontab::ConvertExpiredVerdictScoreContext.new(Time.zone.today).perform
  end
end
