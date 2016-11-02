class Scrap::GetVerdictsTotalResultByStoryTypeContext < BaseContext
  INDEX_URI = 'http://jirs.judicial.gov.tw/FJUD/FJUDQRY01_1.aspx'.freeze
  RESULT_URI = 'http://jirs.judicial.gov.tw/FJUD/FJUDQRY02_1.aspx'.freeze

  before_perform :total_result

  class << self
    def perform(court, type, start_date, end_date)
      new(court, type, start_date, end_date).perform
    end
  end

  def initialize(court, type, start_date, end_date)
    @court = court
    @type = type
    @start_date = start_date
    @end_date = end_date
  end

  def perform
    run_callbacks :perform do
      @total_result.times.each do |index|
        scrap_id = index + 1
        Scrap::ParseVerdictContext.delay(retry: false).perform(@court, scrap_id, @type, @start_date, @end_date)
      end
    end
  end

  private

  def total_result
    court_value = @court.code + ' ' + @court.scrap_name
    @request_query = "?v_court=#{court_value}&v_sys=#{@type}&keyword=&sdate=#{@start_date}&edate=#{@end_date}"
    response_data = Mechanize.new.get(RESULT_URI + @request_query, {}, INDEX_URI)
    response_data = Nokogiri::HTML(response_data.body)
    @total_result = response_data.content.match(/共\s*([0-9]*)\s*筆/)[1].to_i
  rescue
    request_retry(key: "#{RESULT_URI} / data=#{@request_query} /#{Time.zone.today}")
    @total_result = 0
  end

  def request_retry(key:)
    redis_object = Redis::Counter.new(key, expiration: 1.day)
    if redis_object.value < 12
      self.class.delay_for(1.hour).perform(@court, @type, @start_date, @end_date)
      redis_object.incr
    else
      Logs::AddCrawlerError.parse_verdict_data_error(@crawler_history, :crawler_failed, "取得法院ID-#{@court.id} 判決書總數失敗, 來源網址:#{RESULT_URI}, 參數: #{@request_query}")
    end
  end
end
