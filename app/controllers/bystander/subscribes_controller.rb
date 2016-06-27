class Bystander::SubscribesController < Bystander::BaseController
  def create
    redirect_to bystander_profile_path
  end
end
