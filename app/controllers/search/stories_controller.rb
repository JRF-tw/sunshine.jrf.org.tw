class Search::StoriesController < BaseController

  def index
    @search = Story.newest.ransack(params[:q])
    @stories = @search.result.includes(:court).page(params[:page]).per(10) if params[:q]
  end

  def show
    context = Story::FindContext.new(params)
    if @story = context.perform
      @court = @story.court
    else
      @errors_message = context.error_messages.join(',')
    end
  end
end
