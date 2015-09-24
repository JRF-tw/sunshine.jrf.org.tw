class BaseController < ApplicationController
  
  def index
    set_meta(title: "首頁")
    @banners = Banner.published.order_by_weight
    @suits = Suit.last(3)
    @judges = Profile.judges.had_avatar.shuffle.last(12)
    @prosecutors = Profile.prosecutors.had_avatar.shuffle.last(12)
  end

  def about
    set_meta(title: "關於我們")
  end
end
