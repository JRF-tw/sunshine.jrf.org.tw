class Scrap::ParseVerdictContext < BaseContext
  RESULT_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY02_1.aspx".freeze
  VERDICT_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY03_1.aspx".freeze

  before_perform :get_verdict_data
  before_perform :parse_orginal_data
  before_perform :parse_nokogiri_data
  before_perform :parse_verdict_stroy_type
  before_perform :parse_verdict_word
  before_perform :parse_verdict_publish_date
  before_perform :parse_verdict_content

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
    @sleep_time_interval = rand(1..2)
  end

  def perform
    run_callbacks :perform do
      Scrap::ImportVerdictContext.delay.perform(@court, @orginal_data, @verdict_content, @verdict_word, @verdict_publish_date, @verdict_stroy_type)
    end
  end

  private

  def get_verdict_data
    court_value = @court.code + " " + @court.scrap_name
    verdict_query = "?id=#{@scrap_id}&v_court=#{court_value}&v_sys=#{@type}&jud_year=&jud_case=&jud_no=&jud_no_end=&jud_title=&keyword=&sdate=#{@start_date}&edate=#{@end_date}&page=1&searchkw=&jmain=&cw=0"
    sleep @sleep_time_interval
    @response_data = Mechanize.new.get(VERDICT_URI + verdict_query, {}, RESULT_URI)
  end

  def parse_orginal_data
    @orginal_data = @response_data.body.force_encoding("UTF-8")
  rescue => e
    SlackService.notify_scrap_async("判決書分析資料失敗: parse_orginal_data處理資料為空\n response_data : #{@response_data.body}\n #{e.message}")
  end

  def parse_nokogiri_data
    @nokogiri_data = Nokogiri::HTML(@response_data.body)
  rescue => e
    SlackService.notify_scrap_async("判決書分析資料失敗: parse_nokogiri_data處理資料為空\n response_data : #{@response_data.body}\n #{e.message}")
  end

  def parse_verdict_stroy_type
    @verdict_stroy_type = @nokogiri_data.css("table")[0].css("b").text.match(/\s+(\p{Word}+)類/)[1]
  rescue => e
    SlackService.notify_scrap_async("判決書分析資料失敗: parse_nokogiri_data處理資料為空\n nokogiri_data : #{@nokogiri_data}\n #{e.message}")
  end

  def parse_verdict_word
    @verdict_word = @nokogiri_data.css("table")[4].css("tr")[0].css("td")[1].text
  rescue => e
    SlackService.notify_scrap_async("判決書分析資料失敗: parse_verdict_word處理資料為空\n nokogiri_data : #{@nokogiri_data}\n #{e.message}")
  end

  def parse_verdict_publish_date
    date_string = @nokogiri_data.css("table")[4].css("tr")[1].css("td")[1].text
    @verdict_publish_date = Date.new((date_string[0..2].to_i + 1911), date_string[3..4].to_i, date_string[5..6].to_i)
  rescue => e
    SlackService.notify_scrap_async("判決書分析資料失敗: parse_verdict_content處理資料為空\n nokogiri_data : #{@nokogiri_data}\n #{e.message}")
  end

  def parse_verdict_content
    @verdict_content = @nokogiri_data.css("pre").text
  rescue => e
    SlackService.notify_scrap_async("判決書分析資料失敗: parse_verdict_content處理資料為空\n nokogiri_data : #{@nokogiri_data}\n #{e.message}")
  end
end
