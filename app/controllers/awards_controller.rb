class AwardsController < BaseController
  def index
    @profile = Profile.find(params[:profile_id])
    if @profile.is_hidden?
      not_found
    end
    @awards = @profile.awards.shown.order_by_publish_at.page(params[:page]).per(12)
    @newest_award = @awards.first
    @newest_punishments = @profile.punishments.shown.order_by_relevant_date.first(3)
    @newest_reviews = @profile.reviews.had_title.shown.order_by_publish_at.first(3)
    set_meta(
      title: { name: @profile.name },
      description: { name: @profile.name },
      keywords: { name: @profile.name },
      image: ActionController::Base.helpers.asset_path('hero-profiles-show-M.png')
    )
  end
end
