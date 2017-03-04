class Admin::ScoresController < Admin::BaseController
  before_action(except: [:index]) { add_crumb('評鑑記錄列表', admin_scores_path) }

  def index
    @search = Score::SearchFormObject.new(search_params)
    @scores = Kaminari.paginate_array(@search.result.sort_by(&:created_at).reverse!).page(params[:page]).per(20)
    @admin_page_title = '評鑑記錄列表'
    add_crumb @admin_page_title, '#'
  end

  def schedule
    @score = ScheduleScore.find(params[:id])
    @admin_page_title = "開庭評鑑 - #{@score.id} 的詳細資料"
    add_crumb @admin_page_title, '#'
  end

  def verdict
    @score = VerdictScore.find(params[:id])
    @admin_page_title = "判決評鑑 - #{@score.id} 的詳細資料"
    add_crumb @admin_page_title, '#'
  end

  private

  def search_params
    search_form_params = Score::SearchFormObject::PARAMS
    params.fetch(:score_search_form_object, {}).permit(*search_form_params)
  end
end
