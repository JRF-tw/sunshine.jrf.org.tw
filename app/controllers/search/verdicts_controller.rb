class Search::VerdictsController < BaseController
  before_action :http_auth_for_production

  def show
    context = Story::FindContext.new(params[:court_code], params[:id])
    if @story = context.perform
      @court = @story.court
      @verdict = @story.verdict
      @errors_message = '尚未有判決書' unless @verdict
    else
      @errors_message = context.error_messages.join(',')
    end
  end
end
