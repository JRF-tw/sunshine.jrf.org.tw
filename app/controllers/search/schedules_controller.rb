class Search::SchedulesController < Search::BaseController

  def index
    context = Story::FindContext.new(params[:court_code], params[:id])
    if @story = context.perform
      @court = @story.court
      @schedules = @story.schedules.includes(:branch_judge).page(params[:page]).per(10)
    else
      redirect_as_fail(search_stories_path, context.error_messages.join(','))
    end
  end
end
