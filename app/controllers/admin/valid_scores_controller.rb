class Admin::ValidScoresController < Admin::BaseController
  before_action :valid_score
  before_action :find_type_wording, only: [:show]
  before_action(except: [:index]) { add_crumb('有效評鑑記錄列表', admin_valid_scores_path) }

  def index
    @search = ValidScore.ransack(params[:q])
    @valid_scores = @search.result.includes(:story, :score_rater).order('created_at desc').page(params[:page]).per(20)
    @admin_page_title = '有效評鑑記錄列表'
    add_crumb @admin_page_title, '#'
  end

  def show
    @admin_page_title = "有效#{@type_wording}評鑑 - #{@valid_score.story.identity} 的詳細資料"
    add_crumb @admin_page_title, '#'
  end

  private

  def valid_score
    @valid_score ||= params[:id] ? ValidScore.find(params[:id]) : ValidScore.new
  end

  def find_type_wording
    @type_wording = @valid_score.score_type == 'VerdictScore' ? '判決' : '開庭'
  end
end
