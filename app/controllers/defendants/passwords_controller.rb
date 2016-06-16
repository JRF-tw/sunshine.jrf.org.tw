class Defendants::PasswordsController < Devise::PasswordsController
  include CrudConcern

  prepend_before_filter :require_no_authentication, except: [:send_reset_password_sms]
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

  def send_reset_password_sms
    defendant_params = { identify_number: current_defendant.identify_number, phone_number: current_defendant.phone_number }
    context = Defendant::SendResetPasswordSmsContext.new(defendant_params)
    #TODO refactory
    if context.perform
      redirect_to defendants_profile_path, flash: { success: "已寄送重設密碼簡訊" }
    else
      redirect_to defendants_profile_path, flash: { error: "#{context.error_messages.join(", ")}" }
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
