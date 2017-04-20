class Search::StoriesController < Search::BaseController

  def index
    @search = Story.newest.ransack(params[:q])
    @stories = @search.result.includes(:court).page(params[:page]).per(10) if params[:q]
  end

  def show
    context = Story::FindContext.new(params[:court_code], params[:id])
    if @story = context.perform
      @court = @story.court
    else
      redirect_as_fail(search_stories_path, context.error_messages.join(','))
    end
  end
end
