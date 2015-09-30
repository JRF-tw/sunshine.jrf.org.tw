class ReviewsController < BaseController
  def index
    @profile = Profile.find(params[:profile_id])
    @reviews = @profile.reviews.had_title.order_by_publish_at.page(params[:page]).per(12)
    @newest_award = @profile.awards.order_by_publish_at.first
    @newest_punishments = @profile.punishments.order_by_relevant_date.first(3)
    @newest_reviews = @reviews.first(3)
    set_meta(
      title: "#{@profile.name}的相關新聞紀錄",
      description: "#{@profile.name}的新聞相關清單。",
      keywords: "#{@profile.name}相關新聞,#{@profile.name}",
      image: ActionController::Base.helpers.asset_path('hero-profiles-show-M.png')
    )
  end
end
