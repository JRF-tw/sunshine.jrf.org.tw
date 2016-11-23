class Api::CourtsController < Api::BaseController

  def index
    @courts = Court.all
  end

  def show
    @court = Court.find_by_id(params[:id])

    unless @court
      respond_error('法院id不存在', 404)
    end
  end

end
