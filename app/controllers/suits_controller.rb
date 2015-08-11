class SuitsController < BaseController
  def index
    set_meta(title: "司法恐龍面面觀")
  end

  def show
    @suit = Suit.find(params[:id])
    set_meta(title: "案例內容")
  end
end
