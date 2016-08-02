class Parties::VerdictsController < Parties::BaseController
  def new
  end

  def rule
  end

  def verify
    redirect_to party_profile_path
  end
end
