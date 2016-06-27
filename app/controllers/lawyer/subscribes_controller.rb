class Lawyer::SubscribesController < Lawyer::BaseController
  def create
    redirect_to lawyer_profile_path
  end
end
