class Scrap::ImportScheduleContext < BaseContext
  before_perform  :find_court
  before_perform  :build_data
  before_perform  :get_main_judge
  before_perform  :find_or_create_story
  after_perform   :update_story_is_adjudge
  after_perform   :update_story_adjudge_date
  after_perform   :record_count_to_daily_notify

  class << self
    def perform(court_code, hash)
      new(court_code).perform(hash)
    end
  end

  def initialize(court_code)
    @court_code = court_code
  end

  def perform(hash)
    @hash = hash
    run_callbacks :perform do
      @schedule = @story.schedules.find_or_create_by(court: @court, branch_name: @branch_name, date: @date, branch_judge: @main_judge)
    end
  end

  private

  def find_court
    @court = Court.find_by(code: @court_code)
  end

  def build_data
    @is_adjudge   = @hash[:is_adjudge]
    @story_type   = @hash[:story_type]
    @year         = @hash[:year]
    @word_type    = @hash[:word_type]
    @number       = @hash[:number]
    @date         = @hash[:date]
    @branch_name  = @hash[:branch_name]
  end

  def get_main_judge
    branches = @court.branches.current.where(name: @branch_name)
    branches = branches.where("chamber_name LIKE ? ", "%#{@story_type}%") if branches.map(&:judge_id).uniq.count > 1
    @main_judge = branches.first ? branches.first.judge : nil
    SlackService.notify_analysis_async("庭期分析錯誤 : 取得 審判長法官 資訊為空\n #{@hash}") unless @main_judge
  end

  def find_or_create_story
    @story = @court.stories.find_or_create_by(story_type: @story_type, year: @year, word_type: @word_type, number: @number)
  end

  def update_story_is_adjudge
    @story.update_attributes(is_adjudge: @is_adjudge) if @is_adjudge
  end

  def update_story_adjudge_date
    unless @story.adjudge_date
      @story.update_attributes(adjudge_date: @date) if @is_adjudge
    end
  end

  def record_count_to_daily_notify
    Redis::Counter.new("daily_scrap_schedule_count").increment
  end
end
