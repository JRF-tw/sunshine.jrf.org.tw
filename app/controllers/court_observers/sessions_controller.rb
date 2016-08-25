class CourtObservers::SessionsController < Devise::SessionsController
  layout "observer"

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  private

  def after_sign_in_path_for(_resource)
    court_observer_root_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_court_observer_session_path
  end

end
