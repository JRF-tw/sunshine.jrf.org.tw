class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include MetaTagHelper
  include CharacterConversion

  before_action :http_auth_for_staging

  layout :layout_by_resource

  private

  def http_auth_for_staging
    return unless Rails.env.staging?
    authenticate_or_request_with_http_basic do |username, password|
      username == "myapp" && password == "myapp"
    end
  end

  def layout_by_resource
    if devise_controller? && resource_name == :user
      "admin"
    elsif devise_controller? && resource_name == :bystander
      "bystander"
    end
  end

  def not_found
    raise ActionController::RoutingError, "Not Found"
  end

end

require "base_controller"
require "party/base_controller"
require "bystander/base_controller"
require "lawyer/base_controller"
