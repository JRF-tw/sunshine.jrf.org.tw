class Party::StoriesController < Party::BaseController

  def index
    @search = Story.all.newest.ransack(params[:q])
    @stories = @search.result.page(params[:page]).per(20)
  end
end
