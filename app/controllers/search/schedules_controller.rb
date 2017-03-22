class Search::SchedulesController < BaseController
  def index
    context = Story::FindContext.new(params)
    if @story = context.perform
      @court = @story.court
      @schedules = @story.schedules.page(params[:page]).per(10)
    else
      @errors_message = context.error_messages.join(',')
    end
  end
end
