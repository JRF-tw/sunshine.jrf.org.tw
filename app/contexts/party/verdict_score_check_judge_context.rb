class Party::VerdictScoreCheckJudgeContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :judge_name].freeze

  before_perform :check_story
  before_perform :valid_judge_name, if: :has_judgment?

  def initialize(party)
    @party = party
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      @story
    end
  end

  private

  def check_story
    @story = Party::VerdictScoreCheckInfoContext.new(@party).perform(@params)
  end

  def has_judgment?
    @story.judgment_verdict.present?
  end

  def valid_judge_name
    @judgment = @story.judgment_verdict.try(:last)
    return add_error(:verdict_subscriber_valid_failed, "法官姓名錯誤") if @judgment.main_judge_name != @params[:judge_name]
  end
end
