class Scrap::GetVerdictsContext < BaseContext
  before_perform  :get_courts
  after_perform   :record_intervel_to_daily_notify

  class << self
    def perform
      new.perform
    end
  end

  def initialize
    @start_date = (Time.zone.today - 5.days).strftime('%Y%m%d')
    @end_date = (Time.zone.today + 5.days).strftime('%Y%m%d')
  end

  def perform
    run_callbacks :perform do
      @courts.each do |court|
        Scrap::GetVerdictsByCourtContext.delay(retry: false).perform(court, @start_date, @end_date)
      end
    end
  end

  private

  def get_courts
    @courts = Court.with_codes
  end

  def record_intervel_to_daily_notify
    Redis::Value.new('daily_scrap_verdict_intervel').value = "#{@start_date} ~ #{@end_date}"
  end
end
