class Api::StoriesController < Api::BaseController

  def index
    context = Api::StorySearchContext.new(params)
    @stories = context.perform
    return respond_error(context.error_messages.join(','), 404) unless @stories
    @court = @stories.first.court
  end

  def show
  end
end
