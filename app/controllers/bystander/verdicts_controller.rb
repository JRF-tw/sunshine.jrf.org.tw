class Bystander::VerdictsController < Bystander::BaseController
  def new
  end

  def verify
    redirect_to bystander_profile_path
  end
end
