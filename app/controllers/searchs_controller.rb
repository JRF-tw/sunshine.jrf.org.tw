class SearchsController < BaseController
  def index
    set_meta(title: "我想找")
  end

  def judges
    set_meta(title: "法官搜尋結果")
  end

  def prosecutors
    set_meta(title: "檢察官搜尋結果")
  end

  def suits
    set_meta(title: "案例搜尋結果")
  end
end
