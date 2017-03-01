class Admin::ValidScoresController < Admin::BaseController
  before_action :valid_score
  before_action(except: [:index]) { add_crumb('有效評鑑記錄列表', admin_valid_scores_path) }

  def index
    @search = ValidScore.all.ransack(params[:q])
    @valid_scores = @search.result.includes(:story, :score_rater).order('created_at desc').page(params[:page]).per(20)
    @admin_page_title = '有效評鑑記錄列表'
    add_crumb @admin_page_title, '#'
  end

  def show
    @admin_page_title = "有效評鑑 - #{@valid_score.id} 的詳細資料"
    add_crumb @admin_page_title, '#'
  end

  def valid_score
    @valid_score ||= params[:id] ? ValidScore.find(params[:id]) : ValidScore.new
  end
end
