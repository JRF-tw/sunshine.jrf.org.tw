class ProfilesController < BaseController
  def judges
    set_meta(title: "認識法官")
    @judges = Profile.judges.shuffle
  end

  def prosecutors
    set_meta(title: "認識檢察官")
    @prosecutors = Profile.prosecutors.shuffle
  end

  def show
    @profile = Profile.find(params[:id])
    @careers = @profile.careers.newest
    @current_career = @careers.last
    @suits = @profile.suit_list
    @educations = @profile.educations.newest
    @licenses = @profile.licenses.newest
    @newest_award = @profile.awards.newest.last
    @newest_punishments = @profile.punishments.had_reason.newest.first(3)
    @newest_reviews = @profile.reviews.had_title.newest.first(3)
    set_meta(title: "#{@profile.name}的個人頁")
  end
end
