class Scrap::GetSupremeCourtJudgesContext < BaseContext
  SCRAP_URI = 'http://tps.judicial.gov.tw/about/index.php?parent_id=825'.freeze

  before_perform  :get_judges_data
  after_perform   :get_diff_import_daily_branch
  after_perform   :build_diff_info
  after_perform   :notify_diff_info
  after_perform   :update_diff_branch

  class << self
    def perform
      new.perform
    end
  end

  def initialize
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
    @court = Court.find_or_create_by(full_name: '最高法院')
    @judge_names = []
  end

  def perform
    run_callbacks :perform do
      @judge_names.each do |data_array|
        Scrap::ImportSupremeCourtJudgeContext.new(data_array).perform
      end
    end
  end

  private

  def get_judges_data
    response_data = Mechanize.new.get(SCRAP_URI)
    response_data = Nokogiri::HTML(response_data.body)
    parse_judges_data(response_data)
  rescue
    request_retry(key: "#{SCRAP_URI} / #{Time.zone.today}")
  end

  def parse_judges_data(response_data)
    response_data.css('center').slice(1, 2).each do |data|
      parse_data_to_array(data)
    end
  end

  def parse_data_to_array(data)
    chamber_name = data.css('font')[0].text
    data.css('b').text.squish.split(')').each do |judge|
      @judge_names << [judge[/\p{Han}+/u], judge[/\(./][1], chamber_name]
    end
  end

  def request_retry(key:)
    redis_object = Redis::Counter.new(key, expiration: 1.day)
    if redis_object.value < 12
      self.class.delay_for(1.hour).perform
      redis_object.incr
    else
      Logs::AddCrawlerError.parse_supreme_court_judge_data_error(@crawler_history, :crawler_failed, "爬取最高法院法官錯誤, 來源網址 #{SCRAP_URI}")
    end
    false
  end

  def get_diff_import_daily_branch
    @diff_branch_ids = @court.branches.pluck(:id) - Redis::List.new('import_supreme_branch_ids').values.map(&:to_i)
  end

  def build_diff_info
    @alert_message = '以下最高法院股別不在爬蟲資料內'
    diff_branches = Branch.where(id: @diff_branch_ids)
    diff_branches.each { |branch| @alert_message += "\n法院名稱 : #{branch.court.full_name}\n名稱 : #{branch.name}\n 法庭名稱 : #{branch.chamber_name}" }
  end

  def notify_diff_info
    SlackService.notify_branch_alert(@alert_message) if @diff_branch_ids.present?
  end

  def update_diff_branch
    Branch.where(id: @diff_branch_ids).update_all(missed: true)
    Redis::List.new('import_supreme_branch_ids').clear
  end
end
