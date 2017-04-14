class Search::StoriesController < BaseController
  before_action :http_auth_for_production

  def index
    @search = Story.newest.ransack(params[:q])
    @stories = @search.result.includes(:court, :verdict).page(params[:page]).per(5) if params[:q]
  end

  def show
    context = Story::FindContext.new(params[:court_code], params[:id])
    if @story = context.perform
      @court = @story.court
    else
      @errors_message = context.error_messages.join(',')
    end
  end
end
