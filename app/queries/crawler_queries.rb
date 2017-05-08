class CrawlerQueries

  class << self
    def by_story(story)
      new(court: story.court, type: story.type_for_crawler, year: story.year, word: story.word_type, number: story.number).index_url
    end
  end

  def initialize(court:, scrap_id: 1, type: nil, year: nil, word: nil, number: nil, start_date: nil, end_date: nil)
    @court = court
    @scrap_id = scrap_id
    @type = type
    @year = year
    @word = word
    @number = number
    @start_date = start_date
    @end_date = end_date
  end

  def index_url(page = 1)
    "?v_court=#{court_value}&v_sys=#{@type}&jud_year=#{@year}&jud_case=#{@word}&jud_no=#{@number}&jud_no_end=&jud_title=&keyword=&sdate=#{@start_date}&edate=#{@end_date}&page=#{page}"
  end

  def show_url
    "?id=#{@scrap_id}&v_court=#{court_value}&v_sys=#{@type}&jud_year=#{@year}&jud_case=#{@word}&jud_no=#{@number}&jud_no_end=&jud_title=&keyword=&sdate=#{@start_date}&edate=#{@end_date}&page=1&searchkw=&jmain=&cw=0"
  end

  private

  def court_value
    @court.code + ' ' + @court.scrap_name
  end
end
