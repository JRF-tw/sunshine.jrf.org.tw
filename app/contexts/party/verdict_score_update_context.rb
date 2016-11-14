class Party::VerdictScoreUpdateContext < BaseContext
  PERMITS = [:score_3_1, :note, :appeal_judge].freeze

  before_perform :check_quality_scores
  before_perform :assign_attribute

  def initialize(verdict_score)
    @verdict_score = verdict_score
  end

  def perform(params)
    @params = permit_params(params[:verdict_score] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail) unless @verdict_score.save
      @verdict_score
    end
  end

  private

  def check_quality_scores
    return add_error(:quality_scores_blank) unless @params[:score_3_1].present?
  end

  def assign_attribute
    @verdict_score.assign_attributes(@params)
  end
end
