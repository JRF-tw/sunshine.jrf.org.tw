class Defendants::PasswordsController < Devise::PasswordsController
  layout 'defendant'

  # POST /resource/password
  def create
    context = Defendant::SendResetPasswordSmsContext.new(resource_params)
    if context.perform
      redirect_to new_session_path(:defendant), flash: { success: "已寄送簡訊" }
    else
      redirect_to :back, flash: { error: context.error_messages.join(", ") }
    end
  end

  private

  def after_resetting_password_path_for(resource)
    defendants_root_path
  end
end
