class Scrap::GetVerdictsContext < BaseContext
  INDEX_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY01_1.aspx"
  RESULT_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY02_1.aspx"
  VERDICT_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY03_1.aspx"
  START_DATE = Time.zone.today.strftime("%Y%m%d")
  END_DATE = Time.zone.today.strftime("%Y%m%d")
  SCRAP_TIME_SLEEP_INTERVEL = rand(1..2)

  class << self
    def perform_all
      Court.with_codes.each do |court|
        get_story_types.each do |type|
          total_result(court, type).times.each do |index|
            scrap_id = index + 1
            self.delay.perform(scrap_id, court, type)
          end
        end
      end
    end

    def perform(scrap_id, court, type)
      sleep SCRAP_TIME_SLEEP_INTERVEL
      @import_data = get_verdict_data(scrap_id, court, type)
      Scrap::ImportVerdictContext.new(@import_data, court).perform
    end

    private

    def get_story_types
      response_data = Mechanize.new.get(INDEX_URI)
      response_data = Nokogiri::HTML(response_data.body)
      return response_data.css("input[type='radio']").map{ |row| row.attribute("value").value }.uniq
    rescue => e
      SlackService.notify_async("判決書取得案件分類失敗:  #{e.message}", channel: "#scrap_notify", name: "bug")
    end

    def total_result(court, type)
      court_value = court.code + " " + court.full_name
      request_query = "?v_court=#{court_value}&v_sys=#{type}&keyword=&sdate=#{START_DATE}&edate=#{END_DATE}"
      response_data = Mechanize.new.get(RESULT_URI + request_query, {}, INDEX_URI)
      response_data = Nokogiri::HTML(response_data.body)
      return response_data.content.match(/共\s*([0-9]*)\s*筆/)[1].to_i
    rescue => e
      SlackService.notify_async("判決書搜尋頁面被redirect, 總數計算為0", channel: "#scrap_notify", name: "bug")
      # maybe redirect to error page
      return 0
    end

    def get_verdict_data(scrap_id, court, type)
      court_value = court.code + " " + court.full_name
      verdict_query = "?id=#{scrap_id}&v_court=#{court_value}&v_sys=#{type}&jud_year=&jud_case=&jud_no=&jud_no_end=&jud_title=&keyword=&sdate=#{START_DATE}&edate=#{END_DATE}&page=1&searchkw=&jmain=&cw=0"
      response_data = Mechanize.new.get(VERDICT_URI + verdict_query, {}, RESULT_URI)
      return response_data
    rescue => e
      SlackService.notify_async("判決書取得失敗:  #{e.message}", channel: "#scrap_notify", name: "bug")
    end
  end
end
