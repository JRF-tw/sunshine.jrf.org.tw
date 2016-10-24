class Api::CourtsController < Api::BaseController

  def index
    @courts = Court.all
    respond_200(@courts)
  end
end
