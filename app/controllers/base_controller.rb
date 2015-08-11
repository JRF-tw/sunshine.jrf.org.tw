class BaseController < ApplicationController
  
  def index
    set_meta(title: "首頁")
  end

  def about
    set_meta(title: "關於我們")
  end
end
