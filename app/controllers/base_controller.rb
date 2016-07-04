class BaseController < ApplicationController

  def index
    @banners = Banner.shown.order_by_weight
    @suits = Suit.shown.last(3)
    @judges = Profile.judges.shown.active.had_avatar.sample(12)
    @prosecutors = Profile.prosecutors.shown.active.had_avatar.sample(12)
    image = @banners.count > 0 ? @banners.first.pic_l.L_540.url : nil
    set_meta(
      title: "揭開司法的神秘面紗",
      description: "司法陽光網，帶你揭開司法的神秘面紗，讓我們一起認識法官、認識檢察官，為司法照進陽光。",
      keywords: "司法,認識法官,認識檢察官,不適任法官,不適任檢察官,司法恐龍",
      image: image
    )
  end

  def about
    set_meta(
      title: "關於我們",
      description: "關於司法陽光網。司法資訊不公開是造成人民不信任司法的重要因素之一，我們期待能夠藉由司法陽光網照亮台灣司法黑暗面，追求人民擁有公平審判的權利。",
      keywords: "關於我們,關於司法陽光網",
      image: ActionController::Base.helpers.asset_path('hero-base-about-M.png')
    )
  end
end
