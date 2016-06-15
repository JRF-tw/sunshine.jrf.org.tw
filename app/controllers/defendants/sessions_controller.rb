class Defendants::SessionsController < Devise::SessionsController
  layout 'defendant'

  # POST /resource/sign_in
  def create
    # TODO 檢查帳號是否已經認證手機
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: defendants_profile_path
  end

  private

  def after_sign_in_path_for(resource)
    defendants_profile_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_defendant_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) << :identify_number
  end

end
