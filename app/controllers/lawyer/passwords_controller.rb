class Lawyer::PasswordsController < Devise::PasswordsController
  include CrudConcern
  layout 'lawyer'

  prepend_before_filter :require_no_authentication, except: [:edit, :update, :send_reset_password_mail]

  # POST /resource/password
  def create
    @lawyer = Lawyer.find_by_email(resource_params[:email])
    if @lawyer && @lawyer.confirmed?
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      if successfully_sent?(resource)
        respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
      else
        respond_with(resource)
      end
    elsif @lawyer && !@lawyer.confirmed?
      redirect_to :back, flash: { notice: "該帳號尚未註冊" }
    else
      redirect_to :back, flash: { notice: "無此律師帳號" }
    end
  end

  def edit
    if current_lawyer && Lawyer.with_reset_password_token(params[:reset_password_token]) != current_lawyer
      redirect_as_fail(lawyer_profile_path, "你僅能修改本人的帳號")
    else
      self.resource = resource_class.new
      set_minimum_password_length
      resource.reset_password_token = params[:reset_password_token]
      @lawyer_by_token = Lawyer.with_reset_password_token(params[:reset_password_token])
    end
  end

  def send_reset_password_mail
    context = Lawyer::SendSetPasswordEmailContext.new(current_lawyer)
    context.perform
    redirect_as_success(lawyer_profile_path, "律師 - #{current_lawyer.name} 重設密碼信件已寄出")
  end

  protected

  def after_resetting_password_path_for(resource)
    new_lawyer_session_path
  end

end

