class Score::SearchFormObject < BaseFormObject
  attr_accessor :score_type_eq, :judge_id_eq, :story_id_eq, :rater_type_eq, :rater_id_eq, :created_at_gteq, :created_at_lteq

  def initialize(params = {})
    @params = params
    assign_value
  end

  def result
    schedule_scores_result + verdict_scores_result
  end

  def collect_by_roles
    if @params[:rater_type_eq].present?
      case @params[:rater_type_eq]
      when 'Party'
        party_names
      when 'Lawyer'
        lawyer_names
      when 'CourtObserver'
        observer_names
      end
    else
      []
    end
  end

  def collect_all_roles
    @score_roles = [['律師', 'Lawyer', { 'data-role-names' => lawyer_names.to_json }], ['當事人', 'Party', { 'data-role-names' => party_names.to_json }], ['觀察者', 'CourtObserver', { 'data-role-names' => observer_names.to_json }]]
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

  def party_names
    Party.all.map { |j| ["當事人 - #{j.name}", j.id] }
  end

  def lawyer_names
    Lawyer.all.map { |j| ["律師 - #{j.name}", j.id] }
  end

  def observer_names
    CourtObserver.all.map { |o| ["觀察者 - #{o.name}", o.id] }
  end

  def only_schedule_score?
    @params[:score_type_eq] == 'ScheduleScore' || @params[:judge_id_eq].present?
  end

  def only_verdict_score?
    @params[:score_type_eq] == 'VerdictScore'
  end

  def schedule_scores_result
    only_verdict_score? ? [] : ScheduleScore.ransack(@params).result.includes(:story, :schedule_rater)
  end

  def verdict_scores_result
    only_schedule_score? ? [] : VerdictScore.ransack(@params).result.includes(:story, :verdict_rater)
  end
end
