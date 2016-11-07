class Parties::PasswordsController < Devise::PasswordsController
  include CrudConcern

  prepend_before_action :require_no_authentication, except: [:edit, :update, :send_reset_password_sms]
  before_action :check_party, only: [:edit, :update]

  layout 'party'

  def new
    # meta
    set_meta(
      title: '當事人忘記密碼頁',
      description: '當事人忘記密碼頁',
      keywords: '當事人忘記密碼頁'
    )
    super
  end

  # POST /resource/password
  def create
    context = Party::SendResetPasswordSmsContext.new(resource_params)
    if context.perform
      redirect_to new_session_path(:party), flash: { success: '已寄送簡訊' }
    else
      # for build resource
      params = resource_params.each_with_object({}) { |array, hash| hash[array.first.to_sym] = array.last }
      self.resource = resource_class.new(params)
      flash[:notice] = context.error_messages.join(', ')
      render 'new'
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    set_minimum_password_length
    resource.reset_password_token = params[:reset_password_token]
    # meta
    set_meta(
      title: '當事人重設密碼頁',
      description: '當事人重設密碼頁',
      keywords: '當事人重設密碼頁'
    )
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message(:notice, flash_message)
        sign_in(resource_name, resource) unless current_party
      else
        set_flash_message(:notice, :updated_not_active)
      end
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      set_minimum_password_length
      @party_by_token = resource
      respond_with resource
    end
  end

  def send_reset_password_sms
    party_params = { identify_number: current_party.identify_number, phone_number: current_party.phone_number }
    context = Party::SendResetPasswordSmsContext.new(party_params)
    # TODO: refactory
    if context.perform
      redirect_to party_profile_path, flash: { success: '已寄送重設密碼簡訊' }
    else
      redirect_to party_profile_path, flash: { error: context.error_messages.join(', ').to_s }
    end
  end

  private

  def check_party
    token = params[:reset_password_token] || params[:party][:reset_password_token]
    @party_by_token = Party.with_reset_password_token(token)
    if @party_by_token.nil?
      redirect_as_fail(invalid_edit_path, '無效的驗證連結')
    elsif current_party && current_party != @party_by_token
      redirect_as_fail(invalid_edit_path, '你僅能修改本人的帳號')
    end
  end

  def invalid_edit_path
    current_party ? party_profile_path : new_party_session_path
  end

  def after_sign_in_path_for(_resource)
    party_root_path
  end

  def after_resetting_password_path_for(_resource)
    party_root_path
  end

end
