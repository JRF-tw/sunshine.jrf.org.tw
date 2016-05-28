class Defendants::BaseController < ApplicationController
  layout 'defendant'
  before_action :authenticate_defendant!

  def index
  end
end
