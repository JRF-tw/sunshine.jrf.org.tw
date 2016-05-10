class Scrap::ImportJudgeContext < BaseContext
  EXCEL_URL = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A01_DOWNLOADCVS.jsp?court="
  before_perform  :parse_import_data
  before_perform  :find_court
  before_perform  :build_judge
  before_perform  :assign_default_value
  after_perform   :create_branch


  class << self
    def perform
      get_remote_csv_data.each do |data_string|
        new(data_string).perform
      end
    end

    private

    def get_remote_csv_data
      scrap_file_url = EXCEL_URL + Court.collect_codes.join(",")
      response_data = Mechanize.new.get(scrap_file_url)
      response_data = Nokogiri::HTML(Iconv.new('UTF-8//IGNORE', 'Big5').iconv(response_data.body))
      return response_data.css("body p").text.split("\n")
    rescue => e
      SlackService.scrap_notify_async("法官爬取失敗: 取得csv文件錯誤\n #{e.message}")
    end
  end

  def initialize(data_string)
    @data_string = data_string
  end

  def perform
    run_callbacks :perform do
      return add_error(:data_create_fail, "judge find_or_create fail") unless @judge.save
      @judge
    end
  end

  private

  def parse_import_data
    @row_data = @data_string.split(",")
    @chamber_name = @row_data[0].strip
    @court_name = @chamber_name.match("分院") ? "#{@chamber_name.split("分院")[0]}分院" : "#{@chamber_name.split("法院")[0]}法院"
    @branch_name = @row_data[1].strip
    @judge_name = @row_data[2].gsub("法官", "").squish
  rescue => e
    SlackService.scrap_notify_async("法官爬取失敗: 股別資料解析錯誤\n row_data : #{@row_data}\n #{e.message}")
  end

  def find_court
    @court = Court.find_by(full_name: @court_name)
    return add_error(:data_not_found, "court not found") unless @court
  end

  def build_judge
    @judge = Judge.find_by(court: @court, name: @judge_name) || Judge.new(court: @court, name: @judge_name)
  end

  def assign_default_value
    @judge.assign_attributes(is_active: true, is_hidden: true)
  end

  def create_branch
    Scrap::CreateBranchContext.new(@judge).perform(@chamber_name, @branch_name)
  end
end
