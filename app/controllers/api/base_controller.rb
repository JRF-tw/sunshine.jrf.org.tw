class Api::BaseController < ApplicationController
  include Api::ErrorConcern
  include Api::PaginationConcern
  skip_before_action :verify_authenticity_token
  before_action :enable_cors
  before_action :set_default_format
  before_action :set_default_language

  def page_404
    respond_404("No route matches /#{params[:unmatched_route]}")
  end

  private

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

  def set_default_language
    response.headers['Accept-Language'] = 'zh_TW'
  end
end
