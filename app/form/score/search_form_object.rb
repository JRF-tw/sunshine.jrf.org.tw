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
    @ss = if @params[:score_type_eq] && @params[:score_type_eq] == 'VerdictScore'
            []
          else
            ScheduleScore.all.ransack(ss_query).result.includes(:story, :schedule_rater)
          end
  end

  def vs_result
    @vs = if @params[:score_type_eq] && @params[:score_type_eq] == 'ScheduleScore'
            []
          else
            VerdictScore.all.ransack(vs_query).result.includes(:story, :verdict_rater)
          end
  end

  def ss_query
    query = @params.clone
    query[:schedule_rater_type_eq] = query.delete(:rater_type_eq)
    query[:schedule_rater_id_eq] = query.delete(:rater_id_eq)
    query
  end

  def vs_query
    query = @params.clone
    query[:verdict_rater_type_eq] = query.delete(:rater_type_eq)
    query[:verdict_rater_id_eq] = query.delete(:rater_id_eq)
    query.delete(:judge_id_eq)
    query
  end
end
