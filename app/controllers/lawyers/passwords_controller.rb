class Lawyers::PasswordsController < Devise::PasswordsController
  include CrudConcern
  layout 'lawyer'

  prepend_before_action :require_no_authentication, except: [:edit, :update, :send_reset_password_mail]
  before_action :check_lawyer, only: [:edit, :update]
  before_action :first_time_setting?, only: [:update]

  def new
    # meta
    set_meta(
      title: '律師忘記密碼頁',
      description: '律師忘記密碼頁',
      keywords: '律師忘記密碼頁'
    )
    super
  end

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
    else
      flash.now[:error] = @lawyer && !@lawyer.confirmed? ? '該帳號尚未註冊' : '無此律師帳號'
      self.resource = resource_class.new(email: params[:lawyer][:email])
      render :new
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?
    if resource.errors.empty?
      alert_to_slack if @first_time_setting
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message(:notice, flash_message)
        resource.confirm unless resource.confirmed?
        sign_in(resource_name, resource) unless current_lawyer
      else
        set_flash_message(:notice, :updated_not_active)
      end
      respond_with resource, location: after_resetting_password_path
    else
      set_minimum_password_length
      @lawyer_by_token = resource
      respond_with resource
    end
  end

  def edit
    self.resource = resource_class.new
    set_minimum_password_length
    resource.reset_password_token = params[:reset_password_token]

    # meta
    set_meta(
      title: '律師設定密碼頁',
      description: '律師設定密碼頁',
      keywords: '律師設定密碼頁'
    )
  end

  def send_reset_password_mail
    context = Lawyer::SendSetPasswordEmailContext.new(current_lawyer)
    context.perform
    redirect_as_success(lawyer_profile_path, "律師 - #{current_lawyer.name} 重設密碼信件已寄出")
  end

  protected

  def check_lawyer
    token = params[:reset_password_token] || params[:lawyer][:reset_password_token]
    @lawyer_by_token = Lawyer.with_reset_password_token(token)
    if @lawyer_by_token.nil?
      redirect_as_fail(invalid_edit_path, '無效的驗證連結')
    elsif current_lawyer && current_lawyer != @lawyer_by_token
      redirect_as_fail(invalid_edit_path, '你僅能修改本人的帳號')
    end
  end

  def invalid_edit_path
    current_lawyer ? lawyer_profile_path : new_lawyer_session_path
  end

  def after_resetting_password_path
    lawyer_root_path
  end

  def first_time_setting?
    @first_time_setting = !Lawyer.with_reset_password_token(resource_params[:reset_password_token]).try(:encrypted_password).present?
  end

  def alert_to_slack
    SlackService.notify_user_activity_alert("新律師註冊 : #{SlackService.render_link(admin_lawyer_url(resource, host: Setting.host), resource.name)} 已經申請註冊")
  end

end
