class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include MetaTagHelper
  include CharacterConversion

  before_filter :http_auth_for_staging

  layout :layout_by_resource

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

end
