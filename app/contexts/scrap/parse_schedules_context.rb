class Scrap::ParseSchedulesContext < BaseContext
  SCHEDULE_INFO_URI = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A02.jsp".freeze

  before_perform :scrap_schedule
  before_perform :parse_schedule_info

  class << self
    def perform(court_code, story_type, current_page, page_total, start_date_format, end_date_format)
      new(court_code, story_type, current_page, page_total, start_date_format, end_date_format).perform
    end
  end

  def initialize(court_code, story_type, current_page, page_total, start_date_format, end_date_format)
    @court_code = court_code
    @story_type = story_type
    @current_page = current_page
    @page_total = page_total
    @start_date_format = start_date_format
    @end_date_format = end_date_format
    @sleep_time_interval = rand(1..2)
  end

  def perform
    run_callbacks :perform do
      @hash_array.each do |hash|
        Scrap::ImportScheduleContext.delay(retry: 3).perform(@court_code, hash)
      end
    end
  end

  private

  def scrap_schedule
    sql = "UPPER(CRTID)='#{@court_code}' AND DUDT>='#{@start_date_format}' AND DUDT<='#{@end_date_format}' AND SYS='#{@story_type}'  ORDER BY  DUDT,DUTM,CRMYY,CRMID,CRMNO"
    data = { pageNow: @current_page, sql_conction: sql, pageTotal: @page_total, pageSize: 15, rowStart: 1 }
    sleep @sleep_time_interval
    response_data = Mechanize.new.get(SCHEDULE_INFO_URI, data)
    @data = Nokogiri::HTML(Iconv.new("UTF-8//IGNORE", "Big5").iconv(response_data.body))
  end

  def parse_schedule_info
    @hash_array = []
    scope = @data.css("table")[1].css("tr")
    scope.length.times.each do |index|
      # first row is table desc
      next if index == 0
      row_data = scope[index].css("td")
      hash = {
        story_type: row_data[1].text.strip,
        year: row_data[2].text.strip.to_i,
        word_type: row_data[3].text.strip,
        number: row_data[4].text.squish,
        date: convert_scrap_time(row_data[5].text.strip),
        branch_name: row_data[8].text.strip,
        is_pronounce: row_data[9].text.strip.match("宣判").present?
      }
      @hash_array << hash
    end
  end

  def convert_scrap_time(date_string)
    split_array = date_string.split("/").map(&:to_i)
    year = split_array[0] + 1911
    Date.new(year, split_array[1], split_array[2])
  end
end
