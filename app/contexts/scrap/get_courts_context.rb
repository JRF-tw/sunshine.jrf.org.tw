class Scrap::GetCourtsContext < BaseContext
  SCRAP_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY01_1.aspx".freeze
  before_perform  :get_court_data
  before_perform  :check_db_data_and_notify
  after_perform   :record_intervel_to_daily_notify

  class << self
    def perform
      new.perform
    end
  end

  def perform
    run_callbacks :perform do
      @scrap_data.each do |court_data|
        Scrap::ImportCourtContext.delay(retry: 3).perform(court_data)
      end
    end
  end

  private

  def get_court_data
    @scrap_data = []
    response_data = Mechanize.new.get(SCRAP_URI)
    response_data = Nokogiri::HTML(response_data.body)
    parse_courts_data(response_data).each do |data|
      @scrap_data << { scrap_name: data.text, code: data.attr("value").gsub(data.text, "").squish }
    end
  rescue
    nil
  end

  def parse_courts_data(response_data)
    return response_data.css("table")[2].css("select")[0].css("option")
  rescue => e
    SlackService.notify_scrap_court_error("法院爬取失敗: 解析法院代碼資訊錯誤\n #{e.message}")
  end

  def check_db_data_and_notify
    scrap_court_codes = @scrap_data.map { |data| data[:code] }
    diff_courts = Court.get_courts.where.not(code: scrap_court_codes).where.not(code: nil)
    diff_courts.each do |court|
      SlackService.notify_scrap_court_error("法院資料不再爬蟲資料內 : \n法院ID : #{court.id}\n法院全名 : #{court.full_name}\n法院代碼 : #{court.code}")
    end
  end

  def record_intervel_to_daily_notify
    Redis::Value.new("daily_scrap_court_intervel").value = "#{Time.zone.today} ~ #{Time.zone.today}"
  end
end
