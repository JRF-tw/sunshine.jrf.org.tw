class Parties::AppealsController < Parties::BaseController
  before_action :init_meta, only: [:new]

  def new
  end
end
