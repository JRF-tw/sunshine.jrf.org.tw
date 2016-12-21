class Lawyers::AppealsController < Lawyers::BaseController
  skip_before_action :authenticate_lawyer!

  def new
    set_meta
  end
end
