class Scrap::ImportCourtContext < BaseContext
  SCRAP_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY01_1.aspx"
  before_perform :check_data
  before_perform :find_or_create_court
  before_perform :assign_attrbutes

  class << self
    def perform
      get_court_data.each do |court_data|
        new(court_data).perform
      end
    end

    private

    def get_court_data
      @scrap_data = []
      response_data = Mechanize.new.get(SCRAP_URI)
      response_data =  Nokogiri::HTML(response_data.body)
      parse_courts_data(response_data).each do |data|
        @scrap_data << { fullname: data.text.gsub(" ", ""), code: data.attr("value").gsub(data.text, "").squish }
      end
      return @scrap_data
    rescue => e
      SlackService.scrap_notify_async("法院爬取失敗: 取得法院資料錯誤\n #{e.message}")
    end

    def parse_courts_data(response_data)
      return response_data.css("table")[2].css("select")[0].css("option")
    rescue => e
      SlackService.scrap_notify_async("法院爬取失敗: 解析法院代碼資訊錯誤\n #{e.message}")
    end
  end

  def initialize(data_hash)
    @data_hash = data_hash
    @fullname = data_hash[:fullname]
    @code = data_hash[:code]
  end

  def perform
    run_callbacks :perform do
      return add_error(:data_create_fail, "data not create/update") unless @court.save
      @court
    end
  end

  def check_data
    return add_error(:data_create_fail, "data info incorrect") unless @fullname && @code
  end

  def find_or_create_court
    @court = Court.find_or_create_by(full_name: @fullname)
  end

  def assign_attrbutes
    @court.assign_attributes(code: @code) unless @court.code == @code
    @court.assign_attributes(court_type: "法院") unless @court.court_type
  end
end
