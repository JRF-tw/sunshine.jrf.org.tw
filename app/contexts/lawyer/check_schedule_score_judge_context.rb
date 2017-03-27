class Lawyer::CheckScheduleScoreJudgeContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :story_type, :start_on, :confirmed_realdate, :judge_name].freeze

  before_perform :check_story
  before_perform :check_schedule
  before_perform :check_judge_name
  before_perform :find_court
  before_perform :find_judge
  before_perform :check_judge_already_scored

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      @judge
    end
  end

  private

  def check_story
    context = Lawyer::CheckScheduleScoreInfoContext.new(@lawyer)
    @story = context.perform(@params)
    return add_error(:story_not_found, context.error_messages.join(',')) unless @story
  end

  def check_schedule
    context = Lawyer::CheckScheduleScoreDateContext.new(@lawyer)
    @schedule = context.perform(@params)
    return add_error(:schedule_not_found, context.error_messages.join(',')) if context.has_error?
  end

  def check_judge_name
    return add_error(:judge_name_blank) unless @params[:judge_name].present?
  end

  def find_court
    @court = Court.find(@params[:court_id].to_i)
    return add_error(:court_not_found) unless @court
  end

  def find_judge
    @judge = @court.judges.find_by(name: @params[:judge_name])
    return add_error(:judge_not_found) unless @judge
  end

  def check_judge_already_scored
    @scored_schedule = @lawyer.schedule_scores.where(schedule: @schedule, judge: @judge) if @schedule
    return add_error(:judge_already_scored) if @scored_schedule.present?
  end
end
