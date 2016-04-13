class Scrap::ImportCourtContext < BaseContext
  SCRAP_URI = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A00.jsp"
  before_perform :find_or_create_court

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
      response_data = Nokogiri::HTML(Iconv.new('UTF-8//IGNORE', 'Big5').iconv(response_data.body))
      response_data.css("option").each do |data|
        @scrap_data << { fullname: data.text, code: data.attr("value") }
      end
      return @scrap_data
    rescue => e
      puts "cant scrap website"
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
    puts "create error"
  end

  def find_or_create_court
    return false unless @fullname && @code
    @court = Court.find_or_create_by(full_name: @fullname, code: @code)
  end
end
