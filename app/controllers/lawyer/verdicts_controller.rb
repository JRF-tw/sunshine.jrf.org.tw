class Lawyer::VerdictsController < Lawyer::BaseController
  def new
  end

  def rule
  end

  def verify
    redirect_to lawyer_profile_path
  end
end
