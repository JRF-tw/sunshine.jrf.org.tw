class Scrap::ParseRefereeContext < BaseContext
  include Scrap::AnalysisRefereeContentConcern
  RESULT_URI = 'http://jirs.judicial.gov.tw/FJUD/FJUDQRY02_1.aspx'.freeze
  REFEREE_URI = 'http://jirs.judicial.gov.tw/FJUD/FJUDQRY03_1.aspx'.freeze

  before_perform :init_query
  before_perform :get_referee_data
  before_perform :parse_original_data
  before_perform :parse_nokogiri_data
  before_perform :parse_referee_story_type
  before_perform :parse_referee_word
  before_perform :parse_referee_adjudged_on
  before_perform :parse_referee_content

  class << self
    def perform(court:, scrap_id: nil, type: nil, year: nil, word: nil, number: nil, start_date: nil, end_date: nil)
      new(court: court, scrap_id: scrap_id, type: type, year: year, word: word, number: number, start_date: start_date, end_date: end_date).perform
    end
  end

  def initialize(court:, scrap_id: nil, type: nil, year: nil, word: nil, number: nil, start_date: nil, end_date: nil)
    @court = court
    @scrap_id = scrap_id
    @type = type
    @year = year
    @word = word
    @number = number
    @stary_date = start_date
    @end_date = end_date
    @sleep_time_interval = rand(0.1..1.0).round(3)
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
  end

  def perform
    run_callbacks :perform do
      if referee_type == 'verdict'
        Scrap::ImportVerdictContext.delay(retry: false, queue: 'crawler_verdict').perform(@court, @original_data, @referee_content, @referee_word, @referee_adjudged_on, @referee_story_type)
      else
        Scrap::ImportRuleContext.delay(retry: false, queue: 'crawler_rule').perform(@court, @original_data, @referee_content, @referee_word, @referee_adjudged_on, @referee_story_type)
      end
    end
  end

  private

  def init_query
    @referee_query = CrawlerQueries.new(
      scrap_id: @scrap_id,
      court: @court,
      type: @type,
      year: @year,
      word: @word,
      number: @number,
      start_date: @start_date,
      end_date: @end_date
    ).show_url
  end

  def get_referee_data
    sleep @sleep_time_interval
    @response_data = Mechanize.new.get(REFEREE_URI + @referee_query, {}, RESULT_URI)
  rescue
    request_retry(key: "#{REFEREE_URI} / data=#{@referee_query} /#{Time.zone.today}")
  end

  def parse_original_data
    @original_data = @response_data.body.force_encoding('UTF-8')
  rescue
    Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :parse_data_failed, '解析資訊錯誤 : UTF-8 轉碼失敗')
    false
  end

  def parse_nokogiri_data
    @nokogiri_data = Nokogiri::HTML(@response_data.body)
  rescue
    Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :parse_data_failed, '解析資訊錯誤 : nokogiri 拆解 data 失敗')
    false
  end

  def parse_referee_story_type
    @referee_story_type = @nokogiri_data.css('table')[0].css('b').text.match(/\s+(\p{Word}+)類/)[1]
  rescue
    Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :parse_data_failed, "解析資訊錯誤 : 取得 裁判書類別失敗 Query: #{@referee_query}")
    false
  end

  def parse_referee_word
    @referee_word = @nokogiri_data.css('table')[4].css('tr')[0].css('td')[0].text
  rescue
    Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :parse_data_failed, "解析資訊錯誤 : 取得 裁判書字別失敗 Query: #{@referee_query}")
    false
  end

  def parse_referee_adjudged_on
    date_string = @nokogiri_data.css('table')[4].css('tr')[1].css('td')[0].text.match(/\d+/)[0]
    @referee_adjudged_on = Date.new((date_string[0..2].to_i + 1911), date_string[3..4].to_i, date_string[5..6].to_i)
  rescue
    Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :parse_data_failed, "解析資訊錯誤 : 取得 裁判書發布日期 失敗 Query: #{@referee_query}")
    false
  end

  def parse_referee_content
    @referee_content = @nokogiri_data.css('pre').text
  rescue
    Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :parse_data_failed, "解析資訊錯誤 : 取得 裁判書內容 失敗 Query: #{@referee_query}")
    false
  end

  def referee_type
    parse_referee_type(@referee_content, @crawler_history)
  end

  def request_retry(key:)
    redis_object = Redis::Counter.new(key, expiration: 1.day)
    if redis_object.value < 12
      self.class.delay_for(1.hour).perform(
        scrap_id: @scrap_id,
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
      Logs::AddCrawlerError.parse_referee_data_error(@crawler_history, :crawler_failed, "取得 裁判書內容失敗 : 來源網址: #{REFEREE_URI}, 參數: #{@referee_query}")
    end
    false
  end
end
