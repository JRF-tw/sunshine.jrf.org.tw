class Scrap::GetSchedulesContext < BaseContext
  COURT_INFO_URI = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A01.jsp"
  SCHEDULE_INFO_URI = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A02.jsp"
  PAGE_PER = 15

  class << self
    def perform_all
      @start_date = Time.zone.today
      @end_date = Time.zone.today
      @start_date_format = "#{@start_date.strftime("%Y").to_i - 1911}#{@start_date.strftime('%m%d')}"
      @end_date_format = "#{@end_date.strftime("%Y").to_i - 1911}#{@end_date.strftime('%m%d')}"
      get_courts_info.each do |info|
        info[:page_total].times.each_with_index do |i|
          sleep rand(1..2)
          current_page = i + 1
          self.delay.perform(info, current_page)
        end
      end
    end

    def perform(info, current_page)
      new(info, current_page).perform
    end

    private

    def get_courts_info
      courts_info = []
      Court.collect_codes.each do |court_code|
        story_types = get_story_types_by_court(court_code)
        story_types.each do |story_type|
          page_total = page_total_by_story_type(court_code, story_type)
          courts_info << { court_code: court_code, story_type: story_type, page_total: page_total } if page_total > 0
        end
      end
      return courts_info
    rescue => e
      SlackService.scrap_notify_async("庭期爬取失敗: 爬取各法院資料錯誤\n #{e.message}")
    end

    def get_story_types_by_court(court_code)
      data = { court: court_code }
      response_data = Mechanize.new.post(COURT_INFO_URI, data)
      response_data = Nokogiri::HTML(Iconv.new('UTF-8//IGNORE', 'Big5').iconv(response_data.body))
      return response_data.css("input[type='radio']").map{ |r| r.attribute('value').value }
    rescue => e
      SlackService.scrap_notify_async("庭期爬取失敗: 爬取各法院的庭期類別錯誤\n get_story_types_by_court(#{court_code})\n #{e.message}")
    end

    def page_total_by_story_type(court_code, story_type)
      sql = "UPPER(CRTID)='#{court_code}' AND DUDT>='#{@start_date_format}' AND DUDT<='#{@end_date_format}' AND SYS='#{story_type}'  ORDER BY  DUDT,DUTM,CRMYY,CRMID,CRMNO"
      data = { sql_conction: sql }
      response_data = Mechanize.new.get(SCHEDULE_INFO_URI, data)
      response_data = Nokogiri::HTML(Iconv.new('UTF-8//IGNORE', 'Big5').iconv(response_data.body))
      total = response_data.css('table')[2].css('tr')[0].text.match("合計件數") ? response_data.css('table')[2].css('tr')[0].text.match(/\d+/)[0].to_i : 0
      return total / PAGE_PER + 1
    rescue => e
      SlackService.scrap_notify_async("庭期爬取失敗: 計算各法院撈取分頁數錯誤\n page_total_by_story_type(#{court_code}, #{story_type})\n #{e.message}")
    end
  end

  before_perform :scrap_schedule
  before_perform :parse_schedule_info

  def initialize(info, current_page)
    @info = info
    @court = Court.find_by(code: @info[:court_code])
    @court_code = @info[:court_code]
    @story_type = @info[:story_type]
    @current_page = current_page
    @page_total = @info[:page_total]
  end

  def perform
    run_callbacks :perform do
      @hash_array.each do |data_hash|
        Scrap::ImportScheduleContext.new(@court).perform(data_hash)
      end
    end
  end

  private

  def scrap_schedule
    sql = "UPPER(CRTID)='#{@court_code}' AND DUDT>='#{@start_date_format}' AND DUDT<='#{@end_date_format}' AND SYS='#{@story_type}'  ORDER BY  DUDT,DUTM,CRMYY,CRMID,CRMNO"
    data = { pageNow: @current_page, sql_conction: sql, pageTotal: @page_total, pageSize: 15, rowStart: 1 }
    response_data = Mechanize.new.get(SCHEDULE_INFO_URI, data)
    @data = Nokogiri::HTML(Iconv.new('UTF-8//IGNORE', 'Big5').iconv(response_data.body))
  rescue => e
    SlackService.scrap_notify_async("庭期爬取失敗: 取得庭期表搜尋內容錯誤\n info : #{@info}\n current_page : #{@current_page}\n #{e.message}")
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
    SlackService.scrap_notify_async("庭期爬取失敗: 解析庭期表搜尋內容錯誤\n info : #{@info}\n current_page : #{@current_page}\n #{e.message}")
  end

  def convert_scrap_time(date_string)
    split_array = date_string.split("/").map(&:to_i)
    year = split_array[0] + 1911
    return Date.new(year, split_array[1], split_array[2])
  rescue => e
    SlackService.scrap_notify_async("庭期爬取失敗: 解析庭期時間錯誤\n convert_scrap_time(#{date_string})\n #{e.message}")
  end
end
