class Lawyer::BaseController < ApplicationController
  include CrudConcern
  layout 'lawyer'
  before_action :authenticate_lawyer!, except: :index
end
