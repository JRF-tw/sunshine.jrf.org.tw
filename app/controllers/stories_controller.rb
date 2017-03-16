class StoriesController < BaseController

  def index
    @search = Story.newest.ransack(params[:q])
    @stories = @search.result.includes(:court).page(params[:page]).per(10) if params[:q]
  end

  def show
  end
end
