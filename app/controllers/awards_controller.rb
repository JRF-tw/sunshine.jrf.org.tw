class AwardsController < BaseController
  def index
    @profile = Profile.find(params[:profile_id])
    @awards = @profile.awards.newest
    @newest_award = @awards.last
    @newest_punishments = @profile.punishments.had_reason.newest.first(3)
    @newest_reviews = @profile.reviews.had_title.newest.first(3)
    set_meta(title: "獎勵記錄")
  end
end
