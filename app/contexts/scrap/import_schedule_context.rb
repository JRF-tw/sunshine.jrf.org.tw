class Scrap::ImportScheduleContext < BaseContext
  ## TODO  COURT_CODES slould collect court.code
  COURT_INFO_URI = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A01.jsp"
  SCHEDULE_INFO_URI = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A02.jsp"
  START_DATE = Time.zone.today
  END_DATE = Time.zone.today
  START_DATE_FORMAT = "#{START_DATE.strftime("%Y").to_i - 1911}#{START_DATE.strftime('%m%d')}"
  END_DATE_FORMAT = "#{END_DATE.strftime("%Y").to_i - 1911}#{END_DATE.strftime('%m%d')}"
  SCRAP_TIME_SLEEP_INTERVEL = rand(1..2)
  PAGE_PER = 15

  class << self
    def perform_all
      get_courts_info.each do |info|
        info[:page_total].times.each_with_index do |i|
          current_page = i + 1
          self.delay.perform(info, current_page)
        end
      end
    end

    def perform(info, current_page)
      sleep SCRAP_TIME_SLEEP_INTERVEL
      new(info, current_page).perform
    end

    private

    def get_courts_info
      courts_info = []
      Court.collect_codes.each do |court_code|
        story_types = get_story_types_by_court(court_code)
        story_types.each do |story_type|
          page_total = page_total_by_story_type(court_code, story_type)
          courts_info << { court_code: court_code, story_type: story_type, page_total: page_total } if page_total > 0
        end
      end
      return courts_info
    end

    def get_story_types_by_court(court_code)
      data = { court: court_code }
      response_data = Mechanize.new.post(COURT_INFO_URI, data)
      response_data = Nokogiri::HTML(Iconv.new('UTF-8//IGNORE', 'Big5').iconv(response_data.body))
      return response_data.css("input[type='radio']").map{ |r| r.attribute('value').value }
    end

    def page_total_by_story_type(court_code, story_type)
      sql = "UPPER(CRTID)='#{court_code}' AND DUDT>='#{START_DATE_FORMAT}' AND DUDT<='#{END_DATE_FORMAT}' AND SYS='#{story_type}'  ORDER BY  DUDT,DUTM,CRMYY,CRMID,CRMNO"
      data = { sql_conction: sql }
      response_data = Mechanize.new.get(SCHEDULE_INFO_URI, data)
      response_data = Nokogiri::HTML(Iconv.new('UTF-8//IGNORE', 'Big5').iconv(response_data.body))
      total = response_data.css('table')[2].css('tr')[0].text.match(/\d+/)[0].to_i
      return total / PAGE_PER + 1
    end
  end

  def initialize(info, current_page)
    @court = Court.find_by(code: info[:court_code])
    @court_code = info[:court_code]
    @story_type = info[:story_type]
    @current_page = current_page
    @page_total = info[:page_total]
  end

  def perform
    run_callbacks :perform do
      scrap_schedule
      parse_schedule_info
      @hash_array.each do |hash|
        story = find_or_create_story(@court, hash)
        find_or_create_schedule(story, hash)
      end
    end
  rescue => e
    puts "create error"
  end

  private

  def scrap_schedule
    sql = "UPPER(CRTID)='#{@court_code}' AND DUDT>='#{START_DATE_FORMAT}' AND DUDT<='#{END_DATE_FORMAT}' AND SYS='#{@story_type}'  ORDER BY  DUDT,DUTM,CRMYY,CRMID,CRMNO"
    data = { pageNow: @current_page, sql_conction: sql, pageTotal: @page_total, pageSize: 15, rowStart: 1 }
    response_data = Mechanize.new.get(SCHEDULE_INFO_URI, data)
    @data = Nokogiri::HTML(Iconv.new('UTF-8//IGNORE', 'Big5').iconv(response_data.body))
  end

  def parse_schedule_info
    @hash_array = []
    scope = @data.css("table")[1].css("tr")
    scope.length.times.each do |index|
      # first row is table desc
      next if index == 0
      row_data = scope[index].css('td')
      hash = {
          story_type: row_data[1].text.strip,
          year: row_data[2].text.strip.to_i,
          word_type: row_data[3].text.strip,
          number: row_data[4].text.squish,
          date: convert_scrap_time(row_data[5].text.strip),
          branch_name: row_data[8].text.strip
      }
      @hash_array << hash
    end
  end

  def convert_scrap_time(date_string)
    split_array = date_string.split("/").map(&:to_i)
    year = split_array[0] + 1911
    return Date.new(year, split_array[1], split_array[2])
  end

  def find_or_create_story(court, hash)
    ## TODO need find main_judge_id by branch
    court.stories.find_or_create_by(story_type: hash[:story_type], year: hash[:year], word_type: hash[:word_type], number: hash[:number])
  end

  def find_or_create_schedule(story, hash)
    story.schedules.find_or_create_by(court: story.court, branch_name: hash[:branch_name], date: hash[:date])
  end
end
