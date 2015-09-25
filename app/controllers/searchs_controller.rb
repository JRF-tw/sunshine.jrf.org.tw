class SearchsController < BaseController
  def index
    set_meta(title: "我想找")
  end

  def suits
    set_meta(title: "案例搜尋結果")
    get_params_utf8(['q', 'state'])
    @suit = Suit.find_state(params_utf8[:state]).front_like_search({title: params_utf8[:q], summary: params_utf8[:q], content: params_utf8[:q], keyword: params_utf8[:q]}).page(params[:page]).per(12)
  end

  def judges
    set_meta(title: "法官搜尋結果")
    get_params_utf8(['q', 'judge'])
    @people = Profile.judges.find_current_court(params_utf8[:judge]).front_like_search({ :name => params_utf8[:q] }).page(params[:page]).per(12)
  end

  def prosecutors
    set_meta(title: "檢察官搜尋結果")
    get_params_utf8(['q', 'prosecutor'])
    @people = Profile.prosecutors.find_current_court(params_utf8[:prosecutor]).front_like_search({ :name => params_utf8[:q] }).page(params[:page]).per(12)
  end

end
