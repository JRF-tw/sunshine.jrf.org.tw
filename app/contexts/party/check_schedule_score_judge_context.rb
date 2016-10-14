class Party::CheckScheduleScoreJudgeContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :story_type, :start_on, :confirmed_realdate, :judge_name].freeze

  before_perform :check_story
  before_perform :check_schedule
  before_perform :check_judge_name
  before_perform :find_judge
  before_perform :check_judge_in_correct_court
  before_perform :check_judge_already_scored

  def initialize(party)
    @party = party
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      @judge
    end
  end

  private

  def check_story
    context = Party::CheckScheduleScoreInfoContext.new(@party)
    @story = context.perform(@params)
    return add_error(:story_not_found, context.error_messages.join(",")) unless @story
  end

  def check_schedule
    context = Party::CheckScheduleScoreDateContext.new(@party)
    @schedule = context.perform(@params)
    return add_error(:schedule_not_found, context.error_messages.join(",")) if context.has_error?
  end

  def check_judge_name
    return add_error(:judge_name_blank) unless @params[:judge_name].present?
  end

  def find_judge
    # TODO : need check same name issue
    @judge = Judge.where(name: @params[:judge_name]).last
    return add_error(:judge_not_found) unless @judge
  end

  def check_judge_in_correct_court
    return add_error(:wrong_court_for_judge) if @judge.current_court_id != @params[:court_id].to_i
  end

  def check_judge_already_scored
    @scored_schedule = @party.schedule_scores.where(schedule: @schedule, judge: @judge) if @schedule
    return add_error(:judge_already_scored) if @scored_schedule.present?
  end
end
