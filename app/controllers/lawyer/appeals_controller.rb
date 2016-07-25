class Lawyer::AppealsController < Lawyer::BaseController
  skip_before_action :authenticate_lawyer!

  def new
  end
end
