class Admin::ScorePresenters

  def initialize(params = {})
    @params = params
  end

  def sorted_score(page: 20)
    Kaminari.paginate_array(scores.sort_by(&:created_at).reverse!).page(@params[:page]).per(page)
  end

  private

  def scores
    schedule_scores_result + verdict_scores_result
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
