class CourtObservers::SubscribesController < CourtObservers::BaseController
  def create
    redirect_to court_observer_profile_path
  end
end
