class Api::VerdictsController < Api::BaseController

  def show
    context = Api::VerdictSearchContext.new(params[:id])
    @verdict = context.perform
    return respond_error(context.error_messages.join(','), 404) unless @verdict
    @court = @verdict.story.court
  end

end
