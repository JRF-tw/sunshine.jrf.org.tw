class Scrap::ParseRefereeContext < BaseContext
  RESULT_URI = 'http://jirs.judicial.gov.tw/FJUD/FJUDQRY02_1.aspx'.freeze
  REFEREE_URI = 'http://jirs.judicial.gov.tw/FJUD/FJUDQRY03_1.aspx'.freeze

  before_perform :get_referee_data
  before_perform :parse_orginal_data
  before_perform :parse_nokogiri_data
  before_perform :parse_referee_story_type
  before_perform :parse_referee_word
  before_perform :parse_referee_publish_date
  before_perform :parse_referee_content
  before_perform :parse_referee_type

  class << self
    def perform(court, scrap_id, type, start_date, end_date)
      new(court, scrap_id, type, start_date, end_date).perform
    end
  end

  def initialize(court, scrap_id, type, start_date, end_date)
    @scrap_id = scrap_id
    @court = court
    @type = type
    @start_date = start_date
    @end_date = end_date
    @sleep_time_interval = rand(0.1..1.0).round(3)
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
  end

  def perform
    run_callbacks :perform do
      if @is_verdict
        Scrap::ImportVerdictContext.delay(retry: false, queue: 'crawler_verdict').perform(@court, @orginal_data, @referee_content, @referee_word, @referee_publish_date, @referee_story_type)
      else
        Scrap::ImportRuleContext.delay(retry: false, queue: 'crawler_rule').perform(@court, @orginal_data, @referee_content, @referee_word, @referee_publish_date, @referee_story_type)
      end
    end
  end

  private

  def get_referee_data
    court_value = @court.code + ' ' + @court.scrap_name
    @referee_query = "?id=#{@scrap_id}&v_court=#{court_value}&v_sys=#{@type}&jud_year=&jud_case=&jud_no=&jud_no_end=&jud_title=&keyword=&sdate=#{@start_date}&edate=#{@end_date}&page=1&searchkw=&jmain=&cw=0"
    sleep @sleep_time_interval
    @response_data = Mechanize.new.get(REFEREE_URI + @referee_query, {}, RESULT_URI)
  rescue
    request_retry(key: "#{REFEREE_URI} / data=#{@referee_query} /#{Time.zone.today}")
  end

  def parse_orginal_data
    @orginal_data = @response_data.body.force_encoding('UTF-8')
  rescue
    Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :parse_data_failed, '解析資訊錯誤 : UTF-8 轉碼失敗')
    false
  end

  def parse_nokogiri_data
    @nokogiri_data = Nokogiri::HTML(@response_data.body)
  rescue
    Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :parse_data_failed, '解析資訊錯誤 : nokogiri 拆解 data 失敗')
    false
  end

  def parse_referee_story_type
    @referee_story_type = @nokogiri_data.css('table')[0].css('b').text.match(/\s+(\p{Word}+)類/)[1]
  rescue
    Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :parse_data_failed, '解析資訊錯誤 : 取得 裁判書類別 失敗')
    false
  end

  def parse_referee_word
    @referee_word = @nokogiri_data.css('table')[4].css('tr')[0].css('td')[0].text
  rescue
    Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :parse_data_failed, '解析資訊錯誤 : 取得 裁判書字別 失敗')
    false
  end

  def parse_referee_publish_date
    date_string = @nokogiri_data.css('table')[4].css('tr')[1].css('td')[0].text.match(/\d+/)[0]
    @referee_publish_date = Date.new((date_string[0..2].to_i + 1911), date_string[3..4].to_i, date_string[5..6].to_i)
  rescue
    Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :parse_data_failed, '解析資訊錯誤 : 取得 裁判書發布日期 失敗')
    false
  end

  def parse_referee_content
    @referee_content = @nokogiri_data.css('pre').text
  rescue
    Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :parse_data_failed, '解析資訊錯誤 : 取得 裁判書內容 失敗')
    false
  end

  def parse_referee_type
    @is_verdict = @referee_content.split.first.match(/判決/).present?
    true
  rescue
    Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :parse_data_failed, "解析資訊錯誤 : 取得 裁判書類型 失敗, 內文: #{@referee_content}")
    false
  end

  def request_retry(key:)
    redis_object = Redis::Counter.new(key, expiration: 1.day)
    if redis_object.value < 12
      self.class.delay_for(1.hour).perform(@court, @scrap_id, @type, @start_date, @end_date)
      redis_object.incr
    else
      Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :crawler_failed, "取得 裁判書內容失敗 : 來源網址: #{REFEREE_URI}, 參數: #{@referee_query}")
    end
    false
  end
end
