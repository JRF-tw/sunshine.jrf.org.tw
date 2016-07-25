class Observer::SubscribesController < Observer::BaseController
  def create
    redirect_to observer_profile_path
  end
end
