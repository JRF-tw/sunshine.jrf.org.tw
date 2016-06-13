class Bystanders::BaseController  < ApplicationController
  before_action :authenticate_bystander!

  layout 'bystander'

  def index
  end

end
