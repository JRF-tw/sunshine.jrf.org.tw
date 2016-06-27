class Party::SubscribesController < Party::BaseController
  def create
    redirect_to party_profile_path
  end
end
