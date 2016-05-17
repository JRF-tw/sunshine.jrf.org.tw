class Scrap::GetCourtsContext < BaseContext
  SCRAP_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY01_1.aspx"
  before_perform :get_court_data
  before_perform :match_db_data
  after_perform :record_intervel_to_daily_notify

  def perform
    run_callbacks :perform do
      @scrap_data.each do |court_data|
        Scrap::ImportCourtContext.delay.perform(court_data)
      end
    end
  end

  private

  def get_court_data
    @scrap_data = []
    response_data = Mechanize.new.get(SCRAP_URI)
    response_data =  Nokogiri::HTML(response_data.body)
    parse_courts_data(response_data).each do |data|
      @scrap_data << { scrap_name: data.text, code: data.attr("value").gsub(data.text, "").squish }
    end
  rescue => e
    SlackService.scrap_notify_async("法院爬取失敗: 取得法院資料錯誤\n #{e.message}")
  end

  def parse_courts_data(response_data)
    return response_data.css("table")[2].css("select")[0].css("option")
  rescue => e
    SlackService.scrap_notify_async("法院爬取失敗: 解析法院代碼資訊錯誤\n #{e.message}")
  end

  def match_db_data
    scrap_courts_names = @scrap_data.map{ |data| data[:scrap_name] }
    diff_courts = Court.get_courts.where.not(scrap_name: scrap_courts_names).where.not(scrap_name: nil)
    SlackService.scrap_notify_async("法院資料不再爬蟲資料內 : #{diff_courts.map(&:scrap_name).join(",")}") if diff_courts.count > 0
  end

  def record_intervel_to_daily_notify
    Redis::Value.new("daily_scrap_court_intervel").value = "#{Date.today.to_s} ~ #{Date.today.to_s}"
  end
end
