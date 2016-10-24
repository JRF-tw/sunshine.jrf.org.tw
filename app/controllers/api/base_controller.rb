class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :enable_cors
  before_action :set_default_format
  rescue_from Exception, with: :respond_500
  rescue_from ActionController::RoutingError, with: :respond_404

  def page_404
    raise ActionController::RoutingError, "No route matches /#{params[:unmatched_route]}"
  end

  private

  def respond_200(hash_data)
    response.headers['Accept-Language'] = 'zh_TW'
    render json: hash_data
  end

  def respond_error(message, status = nil)
    status ||= 400
    render json: { message: message }, status: status
  end

  def respond_500(exception)
    respond_error(exception.message, 500)
  end

  def respond_404(exception)
    respond_error(exception.message, 404)
  end

  def enable_cors
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Atmosphere-tracking-id, X-Atmosphere-Framework, X-Cache-Date, Content-Type, X-Atmosphere-Transport, X-Remote, api_key, auth_token, *'
    response.headers['Access-Control-Request-Method'] = 'GET, POST, PUT, DELETE'
    response.headers['Access-Control-Request-Headers'] = 'Origin, X-Atmosphere-tracking-id, X-Atmosphere-Framework, X-Cache-Date, Content-Type, X-Atmosphere-Transport,  X-Remote, api_key, *'
  end

  def set_default_format
    request.format = 'json'
  end
end
