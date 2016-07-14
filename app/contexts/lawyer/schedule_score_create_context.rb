class Lawyer::ScheduleScoreCreateContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :date, :confirmed_realdate, :judge_name, :command_score, :attitude_score, :note, :appeal_judge].freeze

  # before_perform :can_not_score
  before_perform :check_command_score
  before_perform :check_attitude_score
  before_perform :check_story
  before_perform :check_schedule
  before_perform :check_judge
  before_perform :build_schedule_score
  before_perform :assign_attribute

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_create_fail, "開庭已經評論") unless @schedule_score.save
      @schedule_score
    end
  end

  private

  def can_not_score
    # TODO : Block user
  end

  def check_command_score
    return add_error(:date_blank, "訴訟指揮分數為必填") unless @params[:command_score].present?
  end

  def check_attitude_score
    return add_error(:date_blank, "開庭態度分數為必填") unless @params[:attitude_score].present?
  end

  def check_story
    @story = Lawyer::CheckScheduleScoreInfoContext.new(@lawyer).perform(@params)
  end

  def check_schedule
    @schedule = Lawyer::CheckScheduleScoreDateContext.new(@lawyer).perform(@params)
  end

  def check_judge
    @judge = Lawyer::CheckScheduleScoreJudgeContext.new(@lawyer).perform(@params)
  end

  def build_schedule_score
    @schedule_score = @lawyer.schedule_scores.new(@params)
  end

  def assign_attribute
    @schedule_score.assign_attributes(schedule: @schedule, judge: @judge)
  end
end
