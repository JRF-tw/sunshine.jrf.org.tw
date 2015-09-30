class ProfilesController < BaseController
  def judges
    @judges = Profile.judges.random.page(params[:page]).per(12)
    set_meta(
      title: "認識法官",
      description: "認識法官，決定當事人一生的法官，究竟有什麼紀錄？帶您來看看！",
      keywords: "認識法官,法官,法院",
      image: ActionController::Base.helpers.asset_path('hero-profiles-judges-M.png')
    )
  end

  def prosecutors
    @prosecutors = Profile.prosecutors.random.page(params[:page]).per(12)
    set_meta(
      title: "認識檢察官",
      description: "認識檢察官，代表國家調查案例的檢察官，有什麼背景資料呢？一起來瞭解！",
      keywords: "認識檢察官,檢察官,檢察署",
      image: ActionController::Base.helpers.asset_path('hero-profiles-judges-M.png')
    )
  end

  def show
    @profile = Profile.find(params[:id])
    @careers = @profile.careers.order_by_publish_at
    @suits = @profile.suit_list
    @educations = @profile.educations.order_by_end_at
    @licenses = @profile.licenses.order_by_publish_at
    @newest_award = @profile.awards.order_by_publish_at.first
    @newest_punishments = @profile.punishments.order_by_relevant_date.first(3)
    @newest_reviews = @profile.reviews.had_title.order_by_publish_at.first(3)
    description = ["#{@profile.name}個人資料介紹。"]
    description << "性別#{@profile.gender}、" if @profile.gender.present?
    description << "出生年份#{@profile.birth_year}、" if @profile.birth_year.present?
    description << "現任#{@profile.current}" if @profile.current.present?
    set_meta(
      title: "#{@profile.name}",
      description: description.join(""),
      keywords: "#{@profile.name},#{@profile.current}",
      image: @profile.avatar.L_540.url
    )
  end
end
