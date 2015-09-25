class ProfilesController < BaseController
  def judges
    set_meta(title: "認識法官")
    @judges = Profile.judges.random.page(params[:page]).per(12)
  end

  def prosecutors
    set_meta(title: "認識檢察官")
    @prosecutors = Profile.prosecutors.random.page(params[:page]).per(12)
  end

  def show
    @profile = Profile.find(params[:id])
    @careers = @profile.careers.order_by_publish_at
    @current_career = @careers.last
    @suits = @profile.suit_list
    @educations = @profile.educations.order_by_end_at
    @licenses = @profile.licenses.order_by_publish_at
    @newest_award = @profile.awards.order_by_publish_at.first
    @newest_punishments = @profile.punishments.order_by_relevant_date.first(3)
    @newest_reviews = @profile.reviews.had_title.order_by_publish_at.first(3)
    set_meta(title: "#{@profile.name}的個人頁")
  end
end
