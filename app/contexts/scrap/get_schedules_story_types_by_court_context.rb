class Scrap::GetSchedulesStoryTypesByCourtContext < BaseContext
  COURT_INFO_URI = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A01.jsp".freeze

  before_perform :get_story_types_by_court

  class << self
    def perform(court_code, start_date, end_date)
      new(court_code, start_date, end_date).perform
    end
  end

  def initialize(court_code, start_date, end_date)
    @court_code = court_code
    @start_date = start_date
    @end_date = end_date
    @sleep_time_interval = rand(1..2)
  end

  def perform
    run_callbacks :perform do
      @story_types.each do |story_type|
        Scrap::GetSchedulesPagesByStoryTypeContext.delay(retry: 3).perform(@court_code, story_type, @start_date, @end_date)
      end
    end
  end

  private

  def get_story_types_by_court
    data = { court: @court_code }
    sleep @sleep_time_interval
    response_data = Mechanize.new.post(COURT_INFO_URI, data)
    response_data = Nokogiri::HTML(Iconv.new("UTF-8//IGNORE", "Big5").iconv(response_data.body))
    @story_types = response_data.css("input[type='radio']").map { |r| r.attribute("value").value }
  end
end
