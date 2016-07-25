class SubscriberAfterJudgeNoticeWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily.hour_of_day(7)
  end

  def perform
    Crontab::SubscribeStoryAfterJudgeNotifyContext.new(Time.zone.today).perform
  end
end
