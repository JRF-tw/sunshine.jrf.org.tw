class Scrap::ImportCourtContext < BaseContext
  SCRAP_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY01_1.aspx"
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
      response_data =  Nokogiri::HTML(response_data.body)
      data =  response_data.css("table")[2].css("select")[0].css("option")
      data.each do |data|
        @scrap_data << { fullname: data.text, code: data.attr("value").gsub(data.text, "").squish }
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
