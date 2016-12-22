class CourtObservers::EmailsController < CourtObservers::BaseController
  before_action :find_court_observer, only: [:edit, :update]
  before_action :init_meta, only: [:edit]

  def edit
  end

  def update
    @court_observer.skip_confirmation_notification!
    context = CourtObserver::ChangeEmailContext.new(@court_observer)
    if context.perform(params)
      flash[:notice] = '需要重新驗證新的Email'
      redirect_to court_observer_profile_path
    else
      flash.now[:error] = context.error_messages.join(', ')
      render :edit
    end
  end

  def resend_confirmation_mail
    flash[:notice] = '您將在幾分鐘後收到一封電子郵件，內有驗證帳號的步驟說明。'
    CustomDeviseMailer.delay.resend_confirmation_instructions(current_court_observer)
    redirect_to court_observer_profile_path
  end

  private

  def find_court_observer
    @court_observer ||= CourtObserver.find(current_court_observer.id)
  end

  def init_meta
    set_meta
  end
end
