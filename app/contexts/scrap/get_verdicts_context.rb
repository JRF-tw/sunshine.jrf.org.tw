class Scrap::GetVerdictsContext < BaseContext
  INDEX_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY01_1.aspx"
  RESULT_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY02_1.aspx"
  SCRAP_TIME_SLEEP_INTERVEL = rand(1..2)

  def initialize
    @start_date = Time.zone.today.strftime("%Y%m%d")
    @end_date = Time.zone.today.strftime("%Y%m%d")
    @codes = Court.with_codes
  end

  def perform
    run_callbacks :perform do
      @codes.each do |court|
        get_story_types.each do |type|
          total_result(court, type).times.each do |index|
            sleep SCRAP_TIME_SLEEP_INTERVEL
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
  rescue => e
    SlackService.scrap_notify_async("判決書爬取失敗: 取得裁判類別代號錯誤\n #{e.message}")
  end

  def total_result(court, type)
    court_value = court.code + " " + court.full_name
    request_query = "?v_court=#{court_value}&v_sys=#{type}&keyword=&sdate=#{@start_date}&edate=#{@end_date}"
    response_data = Mechanize.new.get(RESULT_URI + request_query, {}, INDEX_URI)
    response_data = Nokogiri::HTML(response_data.body)
    return response_data.content.match(/共\s*([0-9]*)\s*筆/)[1].to_i
  rescue => e
    SlackService.scrap_notify_async("判決書爬取失敗: 判決書搜尋頁面為錯誤頁面\n court : #{court.code}\n type : #{type})\n #{e.message}")
    return 0
  end
end
