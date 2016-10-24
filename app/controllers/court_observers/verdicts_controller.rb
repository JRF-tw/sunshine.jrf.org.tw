class CourtObservers::VerdictsController < CourtObservers::BaseController
  def new
    render 'base/not_found', status: 404
  end
end
