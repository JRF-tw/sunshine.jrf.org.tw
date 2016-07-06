class Observer::SessionsController < Devise::SessionsController
  layout "observer"

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: observer_profile_path
  end

  private

  def after_sign_out_path_for(_resource_or_scope)
    new_court_observer_session_path
  end

end
