class Lawyer::VerdictScoreCheckJudgeContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :judge_name].freeze

  before_perform :check_story
  before_perform :find_judge_in_court, unless: :has_judgment?
  before_perform :find_judge_by_verdict, if: :has_judgment?
  before_perform :valid_judge_correct, if: :has_judgment?

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
    @story = Lawyer::VerdictScoreCheckInfoContext.new(@lawyer).perform(@params)
  end

  def has_judgment?
    @story.judgment_verdict
  end

  def find_judge_in_court
    # TODO : need check same name issue
    @judge = Court.find(@params[:court_id]).judges.where(name: @params[:judge_name]).try(:last)
    return add_error(:data_not_found, "法官不存在") unless @judge
  end

  def find_judge_by_verdict
    @judge = @story.judgment_verdict.main_judge
    return add_error(:data_not_found, "判決書沒有主審法官") unless @judge
  end

  def valid_judge_correct
    return add_error(:verdict_score_valid_failed, "判決書比對法官名稱錯誤") if @judge.name != @params[:judge_name]
  end
end
