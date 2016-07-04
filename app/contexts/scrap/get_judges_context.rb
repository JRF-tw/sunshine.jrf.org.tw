class Scrap::GetJudgesContext < BaseContext
  EXCEL_URL = "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A01_DOWNLOADCVS.jsp?court=".freeze

  before_perform  :get_remote_csv_data
  after_perform   :get_diff_import_daily_branch
  after_perform   :notify_diff_info
  after_perform   :update_diff_branch
  after_perform   :record_intervel_to_daily_notify

  class << self
    def perform
      new.perform
    end
  end

  def perform
    run_callbacks :perform do
      @data.each do |data_string|
        Scrap::ImportJudgeContext.new(data_string).perform
      end
    end
  end

  private

  def get_remote_csv_data
    scrap_file_url = EXCEL_URL + Court.collect_codes.join(",")
    response_data = Mechanize.new.get(scrap_file_url)
    response_data = Nokogiri::HTML(Iconv.new('UTF-8//IGNORE', 'Big5').iconv(response_data.body))
    @data = response_data.css("body p").text.split("\n")
  end

  def get_diff_import_daily_branch
    @diff_branch_ids = Branch.all.map(&:id) - Redis::List.new('daily_import_branch_ids').values.map(&:to_i)
  end

  def notify_diff_info
    @diff_branch_ids.each do |d|
      branch = Branch.find(d)
      SlackService.notify_branch_alert_async("該股別不再目前爬蟲資料內 :\n法院名稱 : #{branch.court.full_name}\n名稱 : #{branch.name}\n 法庭名稱 : #{branch.chamber_name}")
    end
  end

  def update_diff_branch
    Branch.where(id: @diff_branch_ids).update_all(missed: true)
    Redis::List.new('daily_import_branch_ids').clear
  end

  def record_intervel_to_daily_notify
    Redis::Value.new("daily_scrap_judge_intervel").value = "#{Time.zone.today} ~ #{Time.zone.today}"
  end
end
