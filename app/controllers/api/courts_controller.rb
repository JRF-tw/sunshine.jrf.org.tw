class Api::CourtsController < Api::BaseController

  def index
    @court = Court.all
    respond_with @court
  end
end
