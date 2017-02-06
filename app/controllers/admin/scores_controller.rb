class Admin::ScoresController < Admin::BaseController
  before_action(except: [:index]) { add_crumb('評鑑記錄列表', admin_scores_path) }

  def index
    @search = Score::SearchFormObject.new(search_params)
    @scores = Kaminari.paginate_array(@search.result.sort_by(&:created_at).reverse!).page(params[:page]).per(20)
    @admin_page_title = '評鑑記錄列表'
    add_crumb @admin_page_title, '#'
  end

  def ss_show
    @s_score = ScheduleScore.find(params[:id])
    @admin_page_title = "開庭評鑑 - #{@s_score.id} 的詳細資料"
    add_crumb @admin_page_title, '#'
  end

  def vs_show
    @v_score = VerdictScore.find(params[:id])
    @admin_page_title = "判決評鑑 - #{@v_score.id} 的詳細資料"
    add_crumb @admin_page_title, '#'
  end

  private

  def vs_ransack_query
    if params[:q]
      vs_query = params[:q].clone
      vs_query[:verdict_rater_id_eq] = vs_query.delete(:schedule_rater_id_eq)
      vs_query[:verdict_rater_type_eq] = vs_query.delete(:schedule_rater_type_eq)
      vs_query.delete(:judge_id_eq)
      vs_query
    end
  end

  def search_params
    params.fetch(:score_search_form_object, {}).permit(:score_type_eq, :judge_id_eq, :story_id_eq, :rater_type_eq, :rater_id_eq, :created_at_gteq, :created_at_lteq)
  end
end
