class Bystanders::PasswordsController < Devise::PasswordsController
  include CrudConcern
  prepend_before_filter :require_no_authentication, except: [:send_reset_password_mail]

  def send_reset_password_mail
    context = Bystander::SendSetPasswordEmailContext.new(current_bystander)
    context.perform
    redirect_as_success(bystanders_profile_path, "觀察者 - #{current_bystander.name} 重設密碼信件已寄出")
  end

protected

  def after_sign_in_path_for(resource_or_scope)
    bystanders_root_path
  end
end

