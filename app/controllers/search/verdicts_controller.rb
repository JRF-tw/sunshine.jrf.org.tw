class Search::VerdictsController < Search::BaseController

  def show
    context = Story::FindContext.new(params[:court_code], params[:id])
    if @story = context.perform
      @court = @story.court
      @verdict = @story.verdict
      @errors_message = '尚未有判決書' unless @verdict
      set_meta(title: { story: @story.identity })
    else
      redirect_as_fail(search_stories_path, context.error_messages.join(','))
    end
  end
end
