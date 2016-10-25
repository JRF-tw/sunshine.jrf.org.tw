class Api::CourtsController < Api::BaseController

  def index
    @courts = Court.all
    respond_200(@courts)
  end

  def show
    @court = Court.find_by_id(params[:id])
    if @court
      respond_200(@court)
    else
      respond_error('法院id不存在', 404)
    end
  end

end
