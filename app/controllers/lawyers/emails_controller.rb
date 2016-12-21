class Lawyers::EmailsController < Lawyers::BaseController
  before_action :find_lawyer, only: [:edit, :update]

  def edit
    set_meta
  end

  def update
    context = Lawyer::ChangeEmailContext.new(@lawyer)
    if context.perform(params)
      flash[:notice] = '需要重新驗證新的Email'
      redirect_to lawyer_profile_path
    else
      flash.now[:error] = context.error_messages.join(', ')
      render :edit
    end
  end

  def resend_confirmation_mail
    flash[:notice] = '您將在幾分鐘後收到一封電子郵件，內有驗證帳號的步驟說明。'
    CustomDeviseMailer.delay.resend_confirmation_instructions(current_lawyer)
    redirect_to lawyer_profile_path
  end

  def find_lawyer
    @lawyer ||= Lawyer.find(current_lawyer.id)
  end
end
