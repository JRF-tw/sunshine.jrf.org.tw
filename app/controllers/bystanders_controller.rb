class BystandersController < ApplicationController
  before_action :authenticate_bystander!, except: :index

  layout 'bystander'

  def index
  end

end
