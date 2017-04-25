class Api::StoriesController < Api::BaseController

  def index
    context = Api::StoriesSearchContext.new(params[:q])
    @stories = context.perform
    return respond_error(context.error_messages.join(','), 404) unless @stories
    @pagination_data, @stories = paginate(@stories.search_sort, 'api_stories_url')
  end

  def show
    context = Story::FindContext.new(params[:court_code], params[:id])
    @story = context.perform
    return respond_error(context.error_messages.join(','), 404) unless @story
    @court = @story.court
  end
end
