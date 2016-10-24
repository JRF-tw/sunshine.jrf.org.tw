class CourtObservers::BaseController < ApplicationController
  layout 'observer'
  include CrudConcern

  before_action :authenticate_court_observer!
end
