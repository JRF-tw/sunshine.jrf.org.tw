class Scrap::GetVerdictsByCourtContext < BaseContext
  INDEX_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY01_1.aspx".freeze

  before_perform :get_story_types

  class << self
    def perform(court, start_date, end_date)
      new(court, start_date, end_date).perform
    end
  end

  def initialize(court, start_date, end_date)
    @court = court
    @start_date = start_date
    @end_date = end_date
  end

  def perform
    run_callbacks :perform do
      @story_types.each do |type|
        Scrap::GetVerdictsTotalResultByStoryTypeContext.delay(retry: 3).perform(@court, type, @start_date, @end_date)
      end
    end
  end

  private

  def get_story_types
    response_data = Mechanize.new.get(INDEX_URI)
    response_data = Nokogiri::HTML(response_data.body)
    @story_types = response_data.css("input[type='radio']").map { |row| row.attribute("value").value }.uniq
  end
end
