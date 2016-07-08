class Lawyer::PasswordsController < Devise::PasswordsController
  include CrudConcern
  layout "lawyer"

  prepend_before_action :require_no_authentication, except: [:edit, :update, :send_reset_password_mail]

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

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message(:notice, flash_message)
        resource.confirm! unless resource.confirmed?
        sign_in(resource_name, resource) unless current_lawyer
      else
        set_flash_message(:notice, :updated_not_active)
      end
      respond_with resource, location: after_resetting_password_path
    else
      set_minimum_password_length
      respond_with resource
    end
  end

  def edit
    lawyer_by_token = Lawyer.with_reset_password_token(params[:reset_password_token])
    if lawyer_by_token.nil?
      redirect_as_fail(invalid_edit_path, "無效的驗證連結")
    elsif current_lawyer && lawyer_by_token != current_lawyer
      redirect_as_fail(invalid_edit_path, "你僅能修改本人的帳號")
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

  def invalid_edit_path
    current_lawyer ? lawyer_profile_path : new_lawyer_session_path
  end

  def after_resetting_password_path
    lawyer_profile_path
  end

end
