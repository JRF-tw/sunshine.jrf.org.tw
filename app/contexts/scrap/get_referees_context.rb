class Scrap::GetRefereesContext < BaseContext
  START_TIME = (Time.zone.today - 2.months).strftime('%Y%m%d').freeze
  END_TIME = Time.zone.today.strftime('%Y%m%d').freeze

  before_perform  :get_courts
  after_perform   :record_intervel_to_daily_notify

  class << self
    def perform
      new.perform
    end
  end

  def initialize(start_date: START_TIME, end_date: END_TIME)
    @start_date = start_date
    @end_date = end_date
  end

  def perform
    run_callbacks :perform do
      @courts.each do |court|
        Scrap::GetRefereesByCourtContext.delay(retry: false, queue: 'crawler_referee').perform(court, @start_date, @end_date)
      end
    end
  end

  private

  def get_courts
    @courts = Court.with_codes
  end

  def record_intervel_to_daily_notify
    Redis::Value.new('daily_scrap_referee_intervel').value = "#{@start_date} ~ #{@end_date}"
  end
end
