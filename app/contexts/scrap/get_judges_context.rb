class Scrap::GetJudgesContext < BaseContext
  EXCEL_URL = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A01_DOWNLOADCVS.jsp?court="

  before_perform  :get_remote_csv_data
  after_perform   :record_intervel_to_daily_notify

  def perform
    run_callbacks :perform do
      @data.each do |data_string|
        Scrap::ImportJudgeContext.delay.perform(data_string)
      end
    end
  end

  private

  def get_remote_csv_data
    scrap_file_url = EXCEL_URL + Court.collect_codes.join(",")
    response_data = Mechanize.new.get(scrap_file_url)
    response_data = Nokogiri::HTML(Iconv.new('UTF-8//IGNORE', 'Big5').iconv(response_data.body))
    @data = response_data.css("body p").text.split("\n")
  rescue => e
    SlackService.notify_scrap_async("法官爬取失敗: 取得csv文件錯誤\n #{e.message}")
  end

  def record_intervel_to_daily_notify
    Redis::Value.new("daily_scrap_judge_intervel").value = "#{Date.today.to_s} ~ #{Date.today.to_s}"
  end
end
