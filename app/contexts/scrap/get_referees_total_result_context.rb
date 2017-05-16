class Scrap::GetRefereesTotalResultContext < BaseContext
  INDEX_URI = 'http://jirs.judicial.gov.tw/FJUD/FJUDQRY01_1.aspx'.freeze
  RESULT_URI = 'http://jirs.judicial.gov.tw/FJUD/FJUDQRY02_1.aspx'.freeze

  PAGE_PER = 20

  before_perform :init_query
  before_perform :total_result

  class << self
    def perform(court:, type: nil, year: nil, word: nil, number: nil, start_date: nil, end_date: nil)
      new(court: court, type: type, year: year, word: word, number: number, start_date: start_date, end_date: end_date).perform
    end

    def perform_by_story(story)
      new(court: story.court, type: story.type_for_crawler, year: story.year, word: story.word_type, number: story.number).perform
    end
  end

  def initialize(court:, type: nil, year: nil, word: nil, number: nil, start_date: nil, end_date: nil)
    @court = court
    @type = type
    @year = year
    @word = word
    @number = number
    @start_date = start_date
    @end_date = end_date
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
  end

  def perform
    run_callbacks :perform do
      @total_page.times.each_with_index do |_, i|
        page_index = i + 1
        page_data = Mechanize.new.get(RESULT_URI + init_query(page_index), {}, INDEX_URI)
        page_data = Nokogiri::HTML(page_data.body)

        PAGE_PER.times.each_with_index do |_, row_index|
          row_index += 1
          scrap_id = i * PAGE_PER + row_index
          next unless scrap_id <= @total_result
          next if story_vericct_file_exist?(split_story_identify(page_data, row_index))
          Scrap::ParseRefereeContext.delay(retry: false, queue: 'crawler_referee').perform(
            scrap_id: scrap_id,
            court: @court,
            type: @type,
            year: @year,
            word: @word,
            number: @number,
            start_date: @start_date,
            end_date: @end_date
          )
        end
      end
    end
  end

  private

  def init_query(page = 1)
    @request_query = CrawlerQueries.new(
      court: @court,
      type: @type,
      year: @year,
      word: @word,
      number: @number,
      start_date: @start_date,
      end_date: @end_date
    ).index_url(page)
  end

  def total_result
    response_data = Mechanize.new.get(RESULT_URI + @request_query, {}, INDEX_URI)
    response_data = Nokogiri::HTML(response_data.body)
    @total_result = response_data.content.match(/共\s*([0-9]*)\s*筆/)[1].to_i
    @total_page = response_data.content.match(/共\s*([0-9]*)\s*頁/)[1].to_i
  rescue
    @total_result = 0
    @total_page = 0
    request_retry(key: "#{RESULT_URI} / data=#{@request_query} /#{Time.zone.today}")
  end

  def request_retry(key:)
    redis_object = Redis::Counter.new(key, expiration: 1.day)
    if redis_object.value < 12
      self.class.delay_for(1.hour, queue: 'crawler_referee').perform(
        court: @court,
        type: @type,
        year: @year,
        word: @word,
        number: @number,
        start_date: @start_date,
        end_date: @end_date
      )
      redis_object.incr
    else
      Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :crawler_failed, "取得法院ID-#{@court.id} 判決書總數失敗, 來源網址:#{RESULT_URI}, 參數: #{@request_query}")
    end
  end

  def split_story_identify(page_data, row_index)
    begin
      row_data = page_data.css('tbody').css('tr')[row_index]
      return row_data.css('td')[1].text.gsub(/(\s)|(\(\w+\))/, '').split(',') if row_data
    rescue NoMethodError
      Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :crawler_failed, "裁判書列表抓取錯誤, 來源網址:#{RESULT_URI}, 參數: #{@request_query}, 爬取資料 #{page_data.text}")
    end
    Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :crawler_failed, "裁判書筆數抓取錯誤, 來源網址:#{RESULT_URI}, 參數: #{@request_query}, 行數 #{row_index}") if row_data.nil?
    []
  end

  def story_vericct_file_exist?(split_story_identify)
    Story.find_by(year: split_story_identify[0], word_type: split_story_identify[1], number: split_story_identify[2]).try(:verdict).try(:file).present?
  end
end
