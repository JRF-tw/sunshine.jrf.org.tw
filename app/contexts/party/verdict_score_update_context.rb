class Party::VerdictScoreUpdateContext < BaseContext
  PERMITS = [:rating_score, :note, :appeal_judge].freeze

  before_perform :check_rating_score
  before_perform :assign_attribute

  def initialize(party, verdict_score)
    @party = party
    @verdict_score = verdict_score
  end

  def perform(params)
    @params = permit_params(params[:verdict_score] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, "更新失敗") unless @verdict_score.save
      @verdict_score
    end
  end

  private

  def check_rating_score
    return add_error(:data_blank, "裁判滿意度為必填") unless @params[:rating_score].present?
  end

  def assign_attribute
    @verdict_score.assign_attributes(@params)
  end
end
