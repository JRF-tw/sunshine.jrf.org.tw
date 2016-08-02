class Lawyers::SubscribesController < Lawyers::BaseController
  def create
    redirect_to lawyer_profile_path
  end
end
