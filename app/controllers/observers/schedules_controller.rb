class Observers::SchedulesController < Observers::BaseController
  def new
    render "base/not_found", status: 404
  end

  def rule
  end

  def verify
    redirect_to observer_profile_path
  end
end
