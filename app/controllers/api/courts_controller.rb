class Api::CourtsController < Api::BaseController

  def index
    @courts = Court.shown.order_by_weight
  end

  def show
    @court = Court.shown.find_by(code: params[:id])
    respond_error('Court not found.', 404) unless @court
  end

end
