class Observer::VerdictsController < Observer::BaseController
  def new
  end

  def verify
    redirect_to observer_profile_path
  end
end