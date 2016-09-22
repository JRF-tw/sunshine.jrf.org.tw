class Parties::EmailsController < Parties::BaseController
  before_action :find_party, only: [:edit, :update]

  def edit
    # prev_unconfirmed_email = current_party.unconfirmed_email if current_party.respond_to?(:unconfirmed_email)
  end

  def update
    context = Party::ChangeEmailContext.new(@party)
    if context.perform(params)
      flash[:notice] = "需要重新驗證新的Email"
      redirect_to party_profile_path
    else
      flash.now[:error] = context.error_messages.join(", ")
      render :edit
    end
  end

  def resend_confirmation_mail
    flash[:notice] = "您將在幾分鐘後收到一封電子郵件，內有驗證帳號的步驟說明"
    CustomDeviseMailer.delay.resend_confirmation_instructions(current_party)
    redirect_to court_observer_profile_path
  end

  def find_party
    @party ||= Party.find(current_party.id)
  end
end
