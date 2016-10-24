class Lawyers::BaseController < ApplicationController
  layout 'lawyer'
  include CrudConcern

  before_action :authenticate_lawyer!
end
