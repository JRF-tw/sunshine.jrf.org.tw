class Api::SchedulesController < Api::BaseController
  def index
    context = Story::FindContext.new(params)
    @story = context.perform
    return respond_error(context.error_messages.join(','), 404) unless @story
    @court = @story.court
    @schedules = @story.schedules
  end
end
