class Scrap::GetRefereesContext < BaseContext
  before_perform  :get_courts
  after_perform   :record_intervel_to_daily_notify

  class << self
    def perform
      new.perform
    end
  end

  def initialize(start_on: nil, end_on: nil)
    @start_on = start_on || (Time.zone.today - 2.months).strftime('%Y%m%d').freeze
    @end_on = end_on || Time.zone.today.strftime('%Y%m%d').freeze
  end

  def perform
    run_callbacks :perform do
      @courts.each do |court|
        Scrap::GetRefereesByCourtContext.delay(retry: false, queue: 'crawler_referee').perform(court, @start_on, @end_on)
      end
    end
  end

  private

  def get_courts
    @courts = Court.with_codes
  end

  def record_intervel_to_daily_notify
    Redis::Value.new('daily_scrap_referee_intervel').value = "#{@start_on} ~ #{@end_on}"
  end
end
