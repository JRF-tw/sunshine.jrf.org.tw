class SuitsController < BaseController
  def index
    @suit_banners = SuitBanner.shown.order_by_weight
    @suits = Suit.shown.newest.page(params[:page]).per(9)
    set_meta(
      title: "司法恐龍面面觀",
      description: "司法恐龍長怎樣？看看幾個案例，認識司法恐龍！",
      keywords: "司法恐龍,司法恐龍面面觀,恐龍法官,恐龍檢察官",
      image: ActionController::Base.helpers.asset_path('hero-suits-index-M.png')
    )
  end

  def show
    @suit = Suit.find(params[:id])
    @related_judges = @suit.judges
    @related_prosecutors = @suit.prosecutors
    @procedures = @suit.procedures.shown.sort_by_procedure_date
    @last_procedure = @procedures.is_done.first.present? ? @procedures.is_done.first : @procedures.first
    @related_suits = @suit.related_suits.shown.last(3)
    image = @suit.pic.present? ? @suit.pic.L_540.url : nil
    set_meta(
      title: @suit.title,
      description: "#{@suit.title} #{@suit.summary}",
      keywords: "司法恐龍案例,司法案例",
      image: image
    )
  end
end
