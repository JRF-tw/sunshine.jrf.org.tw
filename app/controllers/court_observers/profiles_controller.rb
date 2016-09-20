class CourtObservers::ProfilesController < CourtObservers::BaseController
  def show
  end

  def edit
  end

  def update
    context = CourtObserver::UpdateProfileContext.new(current_court_observer)
    if context.perform(params[:court_observer])
      redirect_to court_observer_profile_path, flash: { success: "個人資訊已修改" }
    else
      flash.now[:error] = context.error_messages.join(", ")
      render :edit
    end
  end
end
