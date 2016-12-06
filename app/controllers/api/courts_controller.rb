class Api::CourtsController < Api::BaseController

  def index
    @courts = Court.all
  end

  def show
    @court = Court.find(params[:id])
  end

end
