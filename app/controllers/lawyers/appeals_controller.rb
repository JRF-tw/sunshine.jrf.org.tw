class Lawyers::AppealsController < Lawyers::BaseController
  skip_before_action :authenticate_lawyer!
  before_action :init_meta, only: [:new]

  def new
  end

  private

  def init_meta
    set_meta
  end
end
