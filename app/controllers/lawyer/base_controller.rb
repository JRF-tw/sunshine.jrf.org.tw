class Lawyer::BaseController < ApplicationController
  layout "lawyer"
  include CrudConcern

  before_action :authenticate_lawyer!
end
