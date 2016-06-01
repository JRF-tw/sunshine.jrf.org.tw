class Lawyers::BaseController < ApplicationController
  layout 'lawyer'
  before_action :authenticate_lawyer!, except: :index

  def index
  end
end
