class Defendants::PasswordsController < Devise::PasswordsController
  layout 'defendant'

  # POST /resource/password
  def create
    context = Defendant::SendResetPasswordSmsContext.new(resource_params)
    if context.perform
      redirect_to new_session_path(:defendant), flash: { success: "已寄送簡訊" }
    else
      # for build resource
      params = self.resource_params.inject({}){ |params,(k,v)| params[k.to_sym] = v; params }

      self.resource = resource_class.new(params)
      flash[:notice] = context.error_messages.join(", ")
      render "new"
    end
  end

  private

  def after_sign_in_path_for(resource)
    defendants_root_path
  end

  def after_resetting_password_path_for(resource)
    defendants_root_path
  end
end
