class SuitsController < BaseController
  def index
    @suit_banners = SuitBanner.shown.order_by_weight
    @suits = Suit.shown.newest.page(params[:page]).per(9)
    init_meta(image: ActionController::Base.helpers.asset_path('hero-suits-index-M.png'))
  end

  def show
    @suit = Suit.find(params[:id])
    if @suit.is_hidden?
      not_found
    end
    @related_judges = @suit.judges
    @related_prosecutors = @suit.prosecutors
    @procedures = @suit.procedures.shown.sort_by_procedure_date
    @last_procedure = @procedures.is_done.first.present? ? @procedures.is_done.first : @procedures.first
    @related_suits = @suit.related_suits.shown.last(3)
    image = @suit.pic.present? ? @suit.pic.L_540.url : nil
    init_meta(
      title: { title: @suit.title },
      description: { title: @suit.title, summary: @suit.summary },
      image: image
    )
  end
end
