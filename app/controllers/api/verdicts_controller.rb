class Api::VerdictsController < Api::BaseController

  def show
    context = Api::VerdictSearchContext.new(params[:id])
    @verdicts = context.perform
    return respond_error(context.error_messages.join(','), 404) unless @verdicts
    @court = @verdicts.first.story.court
  end

end
