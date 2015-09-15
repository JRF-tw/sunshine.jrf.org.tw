class BaseController < ApplicationController
  
  def index
    set_meta(title: "首頁")
    @suits = Suit.last(3)
    @judges = Profile.judges.shuffle.last(12)
    @prosecutors = Profile.prosecutors.shuffle.last(12)
  end

  def about
    set_meta(title: "關於我們")
  end
end
