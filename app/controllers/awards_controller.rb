class AwardsController < BaseController
  def index
    @profile = Profile.find(params[:profile_id])
    @awards = @profile.awards.newest.page(params[:page]).per(12)
    @newest_award = @awards.last
    @newest_punishments = @profile.punishments.newest.first(3)
    @newest_reviews = @profile.reviews.had_title.newest.first(3)
    set_meta(title: "獎勵記錄")
  end
end
