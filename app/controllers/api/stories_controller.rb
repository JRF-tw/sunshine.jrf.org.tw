class Api::StoriesController < Api::BaseController

  def index
    context = Api::StorySearchContext.new(params)
    @stories = context.perform
    return respond_error(context.error_messages.join(','), 404) unless @stories
  end

  def show
    context = Story::FindContext.new(params)
    @story = context.perform
    return respond_error(context.error_messages.join(','), 404) unless @story
    @court = @story.court
  end
end
