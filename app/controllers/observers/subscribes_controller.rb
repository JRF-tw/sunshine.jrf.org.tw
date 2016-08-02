class Observers::SubscribesController < Observers::BaseController
  def create
    redirect_to observer_profile_path
  end
end
