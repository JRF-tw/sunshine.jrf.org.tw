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
      current_court_observer.assign_attributes(email: params[:court_observer][:email])
      flash.now[:error] = context.error_messages.join(", ")
      render :edit
    end
  end

  def resend_confirmation_mail
    flash[:notice] = "您將在幾分鐘後收到一封電子郵件，內有驗證帳號的步驟說明"
    CustomDeviseMailer.delay.resend_confirmation_instructions(current_court_observer)
    redirect_to court_observer_profile_path
  end
end
