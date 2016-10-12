class SubscriberAfterJudgeNoticeWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options retry: 3

  recurrence backfill: true do
    daily.hour_of_day(7)
  end

  def perform
    Crontab::SubscribeStoryAfterJudgeNotifyContext.new(Time.zone.today).perform
  end
end
