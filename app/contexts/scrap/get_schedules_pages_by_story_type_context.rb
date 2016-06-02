class Scrap::GetSchedulesPagesByStoryTypeContext < BaseContext
  SCHEDULE_INFO_URI = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A02.jsp"
  PAGE_PER = 15

  before_perform  :page_total_by_story_type_and_court_code

  class << self
    def perform(court_code, story_type, start_date, end_date)
      new(court_code, story_type, start_date, end_date).perform
    end
  end

  def initialize(court_code, story_type, start_date, end_date)
    @start_date = start_date
    @end_date = end_date
    @start_date_format = "#{@start_date.strftime("%Y").to_i - 1911}#{@start_date.strftime('%m%d')}"
    @end_date_format = "#{@end_date.strftime("%Y").to_i - 1911}#{@end_date.strftime('%m%d')}"
    @court_code = court_code
    @story_type = story_type
    @sleep_time_interval = rand(1..2)
  end

  def perform
    run_callbacks :perform do
      @page_total.times.each_with_index do |i|
        current_page = i + 1
        Scrap::ParseSchedulesContext.delay.perform(@court_code, @story_type, current_page, @page_total, @start_date_format, @end_date_format)
      end
    end
  end

  private

  def page_total_by_story_type_and_court_code
    sql = "UPPER(CRTID)='#{@court_code}' AND DUDT>='#{@start_date_format}' AND DUDT<='#{@end_date_format}' AND SYS='#{@story_type}'  ORDER BY  DUDT,DUTM,CRMYY,CRMID,CRMNO"
    data = { sql_conction: sql }
    sleep @sleep_time_interval
    response_data = Mechanize.new.get(SCHEDULE_INFO_URI, data)
    response_data = Nokogiri::HTML(Iconv.new('UTF-8//IGNORE', 'Big5').iconv(response_data.body))
    if response_data.css('table')[2].css('tr')[0].text.match("合計件數")
      @page_total = (response_data.css('table')[2].css('tr')[0].text.match(/\d+/)[0].to_i) / PAGE_PER + 1
    else
      @page_total = 0
    end

  end
end
