class Search::BaseController < ApplicationController
  include CrudConcern
  before_action :http_auth_for_production
end
