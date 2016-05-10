class Scrap::GetSchedulesContext < BaseContext
  COURT_INFO_URI = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A01.jsp"
  SCHEDULE_INFO_URI = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A02.jsp"
  PAGE_PER = 15

  before_perform :get_courts_info

  def initialize
    @start_date = Time.zone.today
    @end_date = Time.zone.today
    @start_date_format = "#{@start_date.strftime("%Y").to_i - 1911}#{@start_date.strftime('%m%d')}"
    @end_date_format = "#{@end_date.strftime("%Y").to_i - 1911}#{@end_date.strftime('%m%d')}"
    @sleep_time_interval = rand(3..5)
  end

  def perform
    run_callbacks :perform do
      @courts_info.each do |info|
        info[:page_total].times.each_with_index do |i|
          current_page = i + 1
          Scrap::ParseSchedulesContext.new(info, current_page, @start_date_format, @end_date_format).perform
        end
      end
    end
  end

  private

  def get_courts_info
    @courts_info = []
    Court.collect_codes.each do |court_code|
      sleep @sleep_time_interval
      story_types = get_story_types_by_court(court_code)
      story_types.each do |story_type|
        page_total = page_total_by_story_type(court_code, story_type)
        @courts_info << { court_code: court_code, story_type: story_type, page_total: page_total } if page_total > 0
      end
    end
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
    if response_data.css('table')[2].css('tr')[0].text.match("合計件數")
      return (response_data.css('table')[2].css('tr')[0].text.match(/\d+/)[0].to_i) / PAGE_PER + 1
    else
      return 0
    end
  rescue => e
    SlackService.scrap_notify_async("庭期爬取失敗: 計算各法院撈取分頁數錯誤\n page_total_by_story_type(#{court_code}, #{story_type})\n #{e.message}")
  end
end
