class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include MetaTagHelper
  include CharacterConversion

  before_action :http_auth_for_production, if: :private_controller?
  before_action :http_auth_for_staging

  layout :layout_by_resource

  private

  def http_auth_for_staging
    return unless Rails.env.staging?
    authenticate_or_request_with_http_basic do |username, password|
      username == 'myapp' && password == 'myapp'
    end
  end

  def http_auth_for_production
    return unless Rails.env.production?
    authenticate_or_request_with_http_basic do |username, password|
      username == 'my_admin' && password == 'my_admin'
    end
  end

  def private_controller?
    self.class.parent == Lawyers || Parties || CourtObservers
  end

  def layout_by_resource
    if devise_controller? && resource_name == :user
      'admin'
    elsif devise_controller? && resource_name == :court_observer
      'observer'
    end
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

end
