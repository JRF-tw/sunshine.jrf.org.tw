class Api::VerdictsController < Api::BaseController

  def show
    context = Api::VerdictSearchContext.new(params[:id])
    @verdicts = context.perform
    return render json: { errors: context.error_messages.join(',') } unless @verdicts
    @court = @verdicts.first.story.court
  end

end
