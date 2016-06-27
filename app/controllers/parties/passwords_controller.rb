class Parties::PasswordsController < Devise::PasswordsController
  include CrudConcern

  prepend_before_filter :require_no_authentication, except: [:send_reset_password_sms]
  layout 'party'

  # POST /resource/password
  def create
    context = Party::SendResetPasswordSmsContext.new(resource_params)
    if context.perform
      redirect_to new_session_path(:party), flash: { success: "已寄送簡訊" }
    else
      # for build resource
      params = self.resource_params.inject({}){ |params,(k,v)| params[k.to_sym] = v; params }

      self.resource = resource_class.new(params)
      flash[:notice] = context.error_messages.join(", ")
      render "new"
    end
  end

  def send_reset_password_sms
    party_params = { identify_number: current_party.identify_number, phone_number: current_party.phone_number }
    context = Party::SendResetPasswordSmsContext.new(party_params)
    #TODO refactory
    if context.perform
      redirect_to parties_profile_path, flash: { success: "已寄送重設密碼簡訊" }
    else
      redirect_to parties_profile_path, flash: { error: "#{context.error_messages.join(", ")}" }
    end
  end

  private

  def after_sign_in_path_for(resource)
    parties_root_path
  end

  def after_resetting_password_path_for(resource)
    parties_root_path
  end
end
