class SearchsController < BaseController
  def index
    set_meta(image: ActionController::Base.helpers.asset_path('hero-searchs-index-M.png'))
  end

  def judges
    get_params_utf8(['q', 'judge'])
    @judges = Judge.shown.ransack(court_id_eq: params_utf8[:judge], name_cont: params_utf8[:q]).result.includes(:court).order(:name).page(params[:page]).per(12)
    set_meta(image: ActionController::Base.helpers.asset_path('hero-searchs-index-M.png'))
  end

  def prosecutors
    get_params_utf8(['q', 'prosecutor'])
    @prosecutors = Prosecutor.shown.ransack(prosecutors_office_id_eq: params_utf8[:prosecutor], name_cont: params_utf8[:q]).result.includes(:prosecutors_office).order(:name).page(params[:page]).per(12)
    set_meta(
      title: '檢察官搜尋結果',
      description: '檢察官搜尋結果，快來看看有哪些檢察官資料！',
      keywords: '找檢察官,檢察官,檢察署',
      image: ActionController::Base.helpers.asset_path('hero-searchs-index-M.png')
    )
  end

end
