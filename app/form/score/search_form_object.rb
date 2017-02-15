class Score::SearchFormObject < BaseFormObject
  attr_accessor :score_type_eq, :judge_id_eq, :story_id_eq, :rater_type_eq, :rater_id_eq, :created_at_gteq, :created_at_lteq, :score_roles

  def initialize(params = {})
    @params = params
    assign_value
    collect_for_score_roles
  end

  def result
    schedule_scores_result + verdict_scores_result
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

  def schedule_scores_result
    only_verdict_score? ? [] : ScheduleScore.ransack(@params).result.includes(:story, :schedule_rater)
  end

  def verdict_scores_result
    only_schedule_score? ? [] : VerdictScore.ransack(@params).result.includes(:story, :verdict_rater)
  end

  def only_schedule_score?
    @params[:score_type_eq] == 'ScheduleScore' || @params[:judge_id_eq].present?
  end

  def only_verdict_score?
    @params[:score_type_eq] == 'VerdictScore'
  end

  def collect_for_score_roles
    @score_roles = [['律師', 'Lawyer', { 'data-role-names' => collect_for_lawyer_name }], ['當事人', 'Party', { 'data-role-names' => collect_for_party_name }], ['觀察者', 'CourtObserver', { 'data-role-names' => collect_for_observer_name }]]
  end

  def collect_for_party_name
    Party.all.map { |j| ["當事人 - #{j.name}", j.id] }.to_json
  end

  def collect_for_lawyer_name
    Lawyer.all.map { |j| ["律師 - #{j.name}", j.id] }.to_json
  end

  def collect_for_observer_name
    CourtObserver.all.map { |o| ["觀察者 - #{o.name}", o.id] }.to_json
  end
end
