class Scrap::ImportScheduleContext < BaseContext
  before_perform  :build_data
  before_perform  :get_main_judge
  before_perform  :find_or_create_story
  after_perform   :update_story_is_adjudge

  def initialize(court)
    @court = court
  end

  def perform(data_hash)
    @data_hash = data_hash
    run_callbacks :perform do
      @schedule = @story.schedules.find_or_create_by(court: @court, branch_name: @branch_name, date: @date)
    end
  end

  private

  def build_data
    @is_adjudge   = @data_hash[:is_adjudge]
    @story_type   = @data_hash[:story_type]
    @year         = @data_hash[:year]
    @word_type    = @data_hash[:word_type]
    @number       = @data_hash[:number]
    @date         = @data_hash[:date]
    @branch_name  = @data_hash[:branch_name]
  end

  def get_main_judge
    branches = @court.branches.where(name: @branch_name)
    branches = branches.where("chamber_name LIKE ? ", "%#{@story_type}%") if branches.map(&:judge_id).uniq.count > 1
    @main_judge = branches.first ? branches.first.judge : nil
    SlackService.analysis_notify_async("庭期資訊 : #{@verdict_word}, 取得 審判長法官 資訊為空") if @main_judge
  end

  def find_or_create_story
    @story = @court.stories.find_or_create_by(story_type: @story_type, year: @year, word_type: @word_type, number: @number, main_judge: @main_judge)
  end

  def update_story_is_adjudge
    @story.update_attributes(is_adjudge: @is_adjudge) if @is_adjudge
  end

end
