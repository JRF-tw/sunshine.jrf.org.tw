class Lawyer::SchedulesController < Lawyer::BaseController
  def new

  end

  def verify
    redirect_to lawyer_profile_path
  end
end
