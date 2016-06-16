class Bystanders::BaseController  < ApplicationController
  include CrudConcern
  
  before_action :authenticate_bystander!

  layout 'bystander'

  def index
  end

  def profile
  end

end
