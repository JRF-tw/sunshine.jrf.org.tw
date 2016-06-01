class Scrap::GetVerdictsContext < BaseContext
  INDEX_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY01_1.aspx"
  RESULT_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY02_1.aspx"

  after_perform :record_intervel_to_daily_notify

  class << self
    def perform
      new.perform
    end
  end

  def initialize
    @start_date = Time.zone.today.strftime("%Y%m%d") - 5.days
    @end_date = Time.zone.today.strftime("%Y%m%d") + 5.days
    @codes = Court.with_codes
  end

  def perform
    run_callbacks :perform do
      @codes.each do |court|
        get_story_types.each do |type|
          total_result(court, type).times.each do |index|
            sleep rand(1..2)
            scrap_id = index + 1
            Scrap::ParseVerdictContext.new(court, scrap_id, type, @start_date, @end_date).perform
          end
        end
      end
    end
  end

  private

  def get_story_types
    response_data = Mechanize.new.get(INDEX_URI)
    response_data = Nokogiri::HTML(response_data.body)
    return response_data.css("input[type='radio']").map{ |row| row.attribute("value").value }.uniq
  end

  def total_result(court, type)
    court_value = court.code + " " + court.scrap_name
    request_query = "?v_court=#{court_value}&v_sys=#{type}&keyword=&sdate=#{@start_date}&edate=#{@end_date}"
    response_data = Mechanize.new.get(RESULT_URI + request_query, {}, INDEX_URI)
    response_data = Nokogiri::HTML(response_data.body)
    return response_data.content.match(/共\s*([0-9]*)\s*筆/)[1].to_i
  end

  def record_intervel_to_daily_notify
    Redis::Value.new("daily_scrap_verdict_intervel").value = "#{@start_date.to_s} ~ #{@end_date.to_s}"
  end
end
