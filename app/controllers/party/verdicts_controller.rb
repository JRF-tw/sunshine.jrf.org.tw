class Party::VerdictsController < Party::BaseController
  def new
  end

  def verify
    redirect_to party_profile_path
  end
end
