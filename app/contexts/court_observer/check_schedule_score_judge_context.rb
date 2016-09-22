class CourtObserver::CheckScheduleScoreJudgeContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :start_on, :confirmed_realdate, :judge_name].freeze

  before_perform :check_judge_name
  before_perform :find_judge
  before_perform :find_story
  before_perform :find_schedule
  before_perform :check_judge_in_correct_court
  before_perform :check_judge_already_scored

  def initialize(court_observer)
    @court_observer = court_observer
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      @judge
    end
  end

  private

  def check_judge_name
    return add_error(:judge_name_blank) unless @params[:judge_name].present?
  end

  def find_judge
    # TODO : need check same name issue
    @judge = Judge.where(name: @params[:judge_name]).last
    return add_error(:judge_not_found) unless @judge
  end

  def find_story
    context = CourtObserver::CheckScheduleScoreInfoContext.new(@court_observer)
    @story = context.perform(@params)
    return add_error(:story_not_found, context.error_messages.join(",")) unless @story
  end

  def find_schedule
    context = CourtObserver::CheckScheduleScoreDateContext.new(@court_observer)
    @schedule = context.perform(@params)
    return add_error(:schedule_not_found, context.error_messages.join(",")) if context.has_error?
  end

  def check_judge_in_correct_court
    return add_error(:wrong_court_for_judge) if @judge.current_court_id != @params[:court_id].to_i
  end

  def check_judge_already_scored
    @scored_schedule = @court_observer.schedule_scores.where(schedule: @schedule, judge: @judge) if @schedule
    return add_error(:judge_already_scored) if @scored_schedule.present?
  end
end
