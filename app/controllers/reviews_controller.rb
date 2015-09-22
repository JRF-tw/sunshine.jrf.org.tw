class ReviewsController < BaseController
  def index
    @profile = Profile.find(params[:profile_id])
    @reviews = @profile.reviews.had_title.newest.page(params[:page]).per(12)
    @newest_award = @profile.awards.newest.last
    @newest_punishments = @profile.punishments.newest.first(3)
    @newest_reviews = @reviews.first(3)
    set_meta(title: "#{@profile.name}的相關新聞記錄")
  end
end
