class Observer::SchedulesController < Observer::BaseController
  def new
  end

  def rule
  end

  def verify
    redirect_to observer_profile_path
  end
end
