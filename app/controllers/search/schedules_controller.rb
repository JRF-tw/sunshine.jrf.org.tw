class Search::SchedulesController < BaseController
  before_action :http_auth_for_production

  def index
    context = Story::FindContext.new(params[:court_code], params[:id])
    if @story = context.perform
      @court = @story.court
      @schedules = @story.schedules.includes(:branch_judge).page(params[:page]).per(10)
    else
      @errors_message = context.error_messages.join(',')
    end
  end
end
