class Scrap::ImportCourtContext < BaseContext
  SCRAP_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY01_1.aspx"
  before_perform :find_or_create_court

  class << self
    def perform
      get_court_data.each do |court_data|
        new(court_data).perform
      end
    rescue => e
      SlackService.notify_async("法官爬取失敗:  #{e.message}", channel: "#scrap_notify", name: "bug")
    end

    private

    def get_court_data
      @scrap_data = []
      response_data = Mechanize.new.get(SCRAP_URI)
      response_data =  Nokogiri::HTML(response_data.body)
      parse_courts_data(response_data).each do |data|
        @scrap_data << { fullname: data.text, code: data.attr("value").gsub(data.text, "").squish }
      end
      return @scrap_data
    end

    def parse_courts_data(response_data)
      return response_data.css("table")[2].css("select")[0].css("option")
    end
  end

  def initialize(data_hash)
    @data_hash = data_hash
    @fullname = data_hash[:fullname]
    @code = data_hash[:code]
  end

  def perform
    run_callbacks :perform do
      @court
    end
  rescue => e
    SlackService.notify_async("法院匯入失敗:  #{e.message}", channel: "#scrap_notify", name: "bug")
  end

  def find_or_create_court
    return false unless @fullname && @code
    @court = Court.find_or_create_by(full_name: @fullname, code: @code)
  end
end
