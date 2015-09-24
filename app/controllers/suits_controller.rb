class SuitsController < BaseController
  def index
    @suit_banners = SuitBanner.published.order_by_weight
    @suits = Suit.all.newest.page(params[:page]).per(9)
    set_meta(title: "司法恐龍面面觀")
  end

  def show
    @suit = Suit.find(params[:id])
    @related_judges = @suit.judges
    @related_prosecutors = @suit.prosecutors
    @procedures = @suit.procedures.sort_by_procedure_date
    @last_procedure = @procedures.is_done.last.present? ? @procedures.is_done.last : @procedures.first
    @related_suits = @suit.related_suits.last(3)
    set_meta(title: "案例內容")
  end
end
