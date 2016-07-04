class Bystander::PasswordsController < Devise::PasswordsController
  layout 'bystander'

  include CrudConcern
  prepend_before_action :require_no_authentication, except: [:edit, :update, :send_reset_password_mail]

  def edit
    if current_bystander && Bystander.with_reset_password_token(params[:reset_password_token]) != current_bystander
      redirect_as_fail(bystander_profile_path, "你僅能修改本人的帳號")
    else
      self.resource = resource_class.new
      set_minimum_password_length
      resource.reset_password_token = params[:reset_password_token]
      @bystander_by_token = Bystander.with_reset_password_token(params[:reset_password_token])
    end
  end

  def send_reset_password_mail
    context = Bystander::SendSetPasswordEmailContext.new(current_bystander)
    context.perform
    redirect_as_success(bystander_profile_path, "觀察者 - #{current_bystander.name} 重設密碼信件已寄出")
  end

  protected

  def after_sign_in_path_for(_resource_or_scope)
    bystander_profile_path
  end

end
