class CourtObservers::EmailsController < CourtObservers::BaseController

  def edit
  end

  def update
    current_court_observer.skip_confirmation_notification!
    context = CourtObserver::ChangeEmailContext.new(current_court_observer)
    if context.perform(params)
      flash[:notice] = "需要重新驗證新的Email"
      redirect_to court_observer_profile_path
    else
      flash.now[:error] = context.error_messages.join(", ")
      render :edit
    end
  end
end
