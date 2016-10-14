class Lawyer::VerdictScoreCheckJudgeContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :story_type, :judge_name].freeze

  before_perform :check_story
  before_perform :check_judge_name
  before_perform :find_judge_in_court
  before_perform :find_judge_by_verdict
  before_perform :valid_judge_correct

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
    context = Lawyer::VerdictScoreCheckInfoContext.new(@lawyer)
    @story = context.perform(@params)
    return add_error(:data_blank, context.error_messages.join(",")) unless @story
  end

  def check_judge_name
    return add_error(:judge_name_blank) unless @params[:judge_name].present?
  end

  def find_judge_in_court
    # TODO : need check same name issue
    @judge = Court.find(@params[:court_id]).judges.where(name: @params[:judge_name]).try(:last)
    return add_error(:judge_not_found) unless @judge
  end

  def find_judge_by_verdict
    @judge = @story.judgment_verdict.main_judge if @story.judgment_verdict
    return add_error(:main_judge_not_exist) unless @judge
  end

  def valid_judge_correct
    return add_error(:verdict_judge_name_error) if @judge.name != @params[:judge_name]
  end
end
