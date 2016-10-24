# == Schema Information
#
# Table name: profiles
#
#  id                 :integer          not null, primary key
#  name               :string
#  current            :string
#  avatar             :string
#  gender             :string
#  gender_source      :text
#  birth_year         :integer
#  birth_year_source  :text
#  stage              :integer
#  stage_source       :text
#  appointment        :string
#  appointment_source :text
#  memo               :text
#  created_at         :datetime
#  updated_at         :datetime
#  current_court      :string
#  is_active          :boolean
#  is_hidden          :boolean
#  punishments_count  :integer          default(0)
#  current_department :string
#  current_branch     :string
#

class ProfilesController < BaseController
  def judges
    @judges = Profile.judges.shown.active.had_avatar.order_by_name.page(params[:page]).per(12)
    set_meta(
      title: '認識法官',
      description: '認識法官，決定當事人一生的法官，究竟有什麼紀錄？帶您來看看！',
      keywords: '認識法官,法官,法院',
      image: ActionController::Base.helpers.asset_path('hero-profiles-judges-M.png')
    )
  end

  def prosecutors
    @prosecutors = Profile.prosecutors.shown.active.had_avatar.order_by_name.page(params[:page]).per(12)
    set_meta(
      title: '認識檢察官',
      description: '認識檢察官，代表國家調查案例的檢察官，有什麼背景資料呢？一起來瞭解！',
      keywords: '認識檢察官,檢察官,檢察署',
      image: ActionController::Base.helpers.asset_path('hero-profiles-judges-M.png')
    )
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
      title: @profile.name.to_s,
      description: description.join(''),
      keywords: "#{@profile.name},#{@profile.current}",
      image: image
    )
  end
end
