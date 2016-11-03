class Scrap::GetSchedulesContext < BaseContext
  after_perform :record_intervel_to_daily_notify

  class << self
    def perform
      new.perform
    end
  end

  def initialize
    @start_date = Time.zone.today
    @end_date = Time.zone.today + 3.days
  end

  def perform
    run_callbacks :perform do
      Court.collect_codes.each do |court_code|
        Scrap::GetSchedulesStoryTypesByCourtContext.delay(retry: false).perform(court_code, @start_date, @end_date)
      end
    end
  end

  private

  def record_intervel_to_daily_notify
    Redis::Value.new('daily_scrap_schedule_intervel').value = "#{@start_date} ~ #{@end_date}"
  end
end
