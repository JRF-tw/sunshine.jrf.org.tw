class AwardsController < BaseController
  def index
    @profile = Profile.find(params[:profile_id])
    @awards = @profile.awards.order_by_publish_at.page(params[:page]).per(12)
    @newest_award = @awards.first
    @newest_punishments = @profile.punishments.order_by_relevant_date.first(3)
    @newest_reviews = @profile.reviews.had_title.order_by_publish_at.first(3)
    set_meta(title: "獎勵記錄")
  end
end
