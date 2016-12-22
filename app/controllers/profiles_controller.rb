class ProfilesController < BaseController
  def judges
    @judges = Profile.judges.shown.active.had_avatar.order_by_name.page(params[:page]).per(12)
    set_meta(image: ActionController::Base.helpers.asset_path('hero-profiles-judges-M.png'))
  end

  def prosecutors
    @prosecutors = Profile.prosecutors.shown.active.had_avatar.order_by_name.page(params[:page]).per(12)
    set_meta(image: ActionController::Base.helpers.asset_path('hero-profiles-judges-M.png'))
  end

  def show
    @profile = Profile.find(params[:id])
    if @profile.is_hidden?
      not_found
    end
    @careers = @profile.careers.shown.order_by_publish_at
    @suits = @profile.suit_list
    @educations = @profile.educations.shown.order_by_end_at
    @licenses = @profile.licenses.shown.order_by_publish_at
    @newest_award = @profile.awards.shown.order_by_publish_at.first
    @newest_punishments = @profile.punishments.shown.order_by_relevant_date.first(3)
    @newest_reviews = @profile.reviews.shown.had_title.order_by_publish_at.first(3)
    description = ["#{@profile.name}個人資料介紹。"]
    description << "性別#{@profile.gender}、" if @profile.gender.present?
    description << "出生年份#{@profile.birth_year}、" if @profile.birth_year.present?
    description << "現任#{@profile.current}" if @profile.current.present?
    image = @profile.avatar.present? ? @profile.avatar.L_540.url : nil
    set_meta(
      title: { name: @profile.name },
      description: { description: description.join('') },
      keywords: { name: @profile.name, current: @profile.current },
      image: image
    )
  end
end
