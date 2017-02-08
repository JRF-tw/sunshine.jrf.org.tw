class Score::SearchFormObject < BaseFormObject
  attr_accessor :score_type_eq, :judge_id_eq, :story_id_eq, :rater_type_eq, :rater_id_eq, :created_at_gteq, :created_at_lteq

  def initialize(params = {})
    @params = params
    assign_value
  end

  def result
    ss_result + vs_result
  end

  private

  def assign_value
    self.score_type_eq = @params[:score_type_eq]
    self.judge_id_eq = @params[:judge_id_eq]
    self.story_id_eq = @params[:story_id_eq]
    self.rater_type_eq = @params[:rater_type_eq]
    self.rater_id_eq = @params[:rater_id_eq]
    self.created_at_gteq = @params[:created_at_gteq]
    self.created_at_lteq = @params[:created_at_lteq]
  end

  def ss_result
    @ss = only_vs? ? [] : ScheduleScore.ransack(@params).result.includes(:story, :schedule_rater)
  end

  def vs_result
    @vs = only_ss? ? [] : VerdictScore.ransack(@params).result.includes(:story, :verdict_rater)
  end

  def only_ss?
    @params[:score_type_eq] == 'ScheduleScore' || @params[:judge_id_eq].present?
  end

  def only_vs?
    @params[:score_type_eq] == 'VerdictScore'
  end
end
