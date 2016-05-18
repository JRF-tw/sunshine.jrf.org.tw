class Scrap::ParseSchedulesContext < BaseContext
  before_perform :scrap_schedule
  before_perform :parse_schedule_info

  def initialize(info, current_page, start_date_format, end_date_format)
    @info = info
    @court_code = @info[:court_code]
    @story_type = @info[:story_type]
    @current_page = current_page
    @page_total = @info[:page_total]
    @start_date_format = start_date_format
    @end_date_format = end_date_format
  end

  def perform
    run_callbacks :perform do
      @hash_array.each do |hash|
        Scrap::ImportScheduleContext.delay.perform(@court_code, hash)
      end
    end
  end

  private

  def scrap_schedule
    sql = "UPPER(CRTID)='#{@court_code}' AND DUDT>='#{@start_date_format}' AND DUDT<='#{@end_date_format}' AND SYS='#{@story_type}'  ORDER BY  DUDT,DUTM,CRMYY,CRMID,CRMNO"
    data = { pageNow: @current_page, sql_conction: sql, pageTotal: @page_total, pageSize: 15, rowStart: 1 }
    response_data = Mechanize.new.get(Scrap::GetSchedulesContext::SCHEDULE_INFO_URI, data)
    @data = Nokogiri::HTML(Iconv.new('UTF-8//IGNORE', 'Big5').iconv(response_data.body))
  rescue => e
    SlackService.notify_scrap_async("庭期爬取失敗: 取得庭期表搜尋內容錯誤\n info : #{@info}\n current_page : #{@current_page}\n #{e.message}")
  end

  def parse_schedule_info
    @hash_array = []
    scope = @data.css("table")[1].css("tr")
    scope.length.times.each do |index|
      # first row is table desc
      next if index == 0
      row_data = scope[index].css('td')
      hash = {
          story_type: row_data[1].text.strip,
          year: row_data[2].text.strip.to_i,
          word_type: row_data[3].text.strip,
          number: row_data[4].text.squish,
          date: convert_scrap_time(row_data[5].text.strip),
          branch_name: row_data[8].text.strip,
          is_adjudge: row_data[9].text.strip.match("宣判").present?
      }
      @hash_array << hash
    end
  rescue => e
    SlackService.notify_scrap_async("庭期爬取失敗: 解析庭期表搜尋內容錯誤\n info : #{@info}\n current_page : #{@current_page}\n #{e.message}")
  end

  def convert_scrap_time(date_string)
    split_array = date_string.split("/").map(&:to_i)
    year = split_array[0] + 1911
    return Date.new(year, split_array[1], split_array[2])
  rescue => e
    SlackService.notify_scrap_async("庭期爬取失敗: 解析庭期時間錯誤\n convert_scrap_time(#{date_string})\n #{e.message}")
  end
end
