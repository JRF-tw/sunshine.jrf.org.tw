class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  include MetaTagHelper
  include CharacterConversion

  before_filter :http_auth_for_staging

  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
    case resource
    when Bystander 
      bystanders_path
    else
      admin_root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  private

  def http_auth_for_staging
    return unless Rails.env.staging?
    authenticate_or_request_with_http_basic do |username, password|
      username == "myapp" && password == "myapp"
    end
  end

  def layout_by_resource
    "admin" if devise_controller?
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

end
