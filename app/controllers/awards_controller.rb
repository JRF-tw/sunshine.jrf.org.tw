class AwardsController < BaseController
  def index
    @profile = Profile.find(params[:profile_id])
    set_meta(title: "獎勵記錄")
  end
end
