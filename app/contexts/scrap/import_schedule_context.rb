class Scrap::ImportScheduleContext < BaseContext
  ## TODO  COURT_CODES slould collect court.code
  COURT_CODES = ["TPH"]
  COURT_INFO_URI = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A01.jsp"
  SCHEDULE_INFO_URI = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A02.jsp"
  START_DATE = Time.zone.today
  END_DATE = Time.zone.today
  SCRAP_TIME_SLEEP_INTERVEL = rand(1..2)

  class << self
    def perform
      COURT_CODES.each do |court_code|
        court = Court.find_by(code: court_code)
        story_types = get_story_types_by_court(court_code)
        story_types.each do |story_type|
          page_total = page_total_by_story_type(court, story_type)
          page_total.times.each_with_index do |i|
            current_page = i + 1
            response_data = scrap_schedule_by_page(court, story_type, current_page, page_total)
            hash_array = parse_schedule_info(response_data)
            hash_array.each do |hash|
              story = find_or_create_story(court, hash)
              find_or_create_schedule(story, hash)
            end
          end
        end
      end
    end

    private

    def get_story_types_by_court(court_code)
      data = { court: court_code }
      response_data = Mechanize.new.post(COURT_INFO_URI, data)
      response_data = Nokogiri::HTML(Iconv.new('UTF-8//IGNORE', 'Big5').iconv(response_data.body))
      return response_data.css("input[type='radio']").map{ |r| r.attribute('value').value }
    end

    def page_total_by_story_type(court, story_type)
      sql = "UPPER(CRTID)='#{court.code}' AND DUDT>='#{start_date_format}' AND DUDT<='#{end_date_format}' AND SYS='#{story_type}'  ORDER BY  DUDT,DUTM,CRMYY,CRMID,CRMNO"
      data = { sql_conction: sql }
      response_data = Mechanize.new.get(SCHEDULE_INFO_URI, data)
      return response_data.form.field_with(name: "pageTotal").value.to_i
    end

    def scrap_schedule_by_page(court, story_type, current_page, page_total)
      sql = "UPPER(CRTID)='#{court.code}' AND DUDT>='#{start_date_format}' AND DUDT<='#{end_date_format}' AND SYS='#{story_type}'  ORDER BY  DUDT,DUTM,CRMYY,CRMID,CRMNO"
      data = { pageNow: current_page, sql_conction: sql, pageTotal: page_total, pageSize: 15, rowStart: 1 }
      sleep SCRAP_TIME_SLEEP_INTERVEL
      response_data = Mechanize.new.get(SCHEDULE_INFO_URI, data)
      response_data = Nokogiri::HTML(Iconv.new('UTF-8//IGNORE', 'Big5').iconv(response_data.body))
      return response_data
    end

    def start_date_format
      return "#{START_DATE.strftime("%Y").to_i - 1911}#{START_DATE.strftime('%m%d')}"
    end

    def end_date_format
      return "#{END_DATE.strftime("%Y").to_i - 1911}#{END_DATE.strftime('%m%d')}"
    end

    def parse_schedule_info(response_data)
      hash_array = []
      scope = response_data.css("table")[1].css("tr")
      scope.length.times.each do |index|
        # first row is table desc
        next if index == 0
        row_data = scope[index].css('td')
        hash = {
            story_type: row_data[1].text.strip,
            year: row_data[2].text.strip.to_i,
            word_type: row_data[3].text.strip,
            number: row_data[4].text.match(/\d+/)[0],
            date: convert_scrap_time(row_data[5].text.strip),
            branch_name: row_data[8].text.strip
        }
        hash_array << hash
      end
      return hash_array
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
end
