class Party::SchedulesController < Party::BaseController
  def new
  end

  def rule
  end

  def verify
    redirect_to party_profile_path
  end
end
