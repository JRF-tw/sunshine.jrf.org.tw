class Observers::VerdictsController < Observers::BaseController
  def new
    render "base/not_found", status: 404
  end

  def rule
  end
end
