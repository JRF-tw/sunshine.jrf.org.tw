class Api::VerdictsController < Api::BaseController

  def show
    context = Story::FindContext.new(params[:court_code], params[:id])
    @story = context.perform
    return respond_error(context.error_messages.join(','), 404) unless @story
    @court = @story.court
    @verdict = @story.verdict
    return respond_error('此案件尚未有判決書', 404) unless @verdict
  end
end
