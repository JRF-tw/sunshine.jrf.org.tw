class ProsecutorsController < BaseController
  before_action :http_auth_for_production

  def index
    @prosecutors = Prosecutor.shown.order_by_name.page(params[:page]).per(12)
    set_meta(image: ActionController::Base.helpers.asset_path('hero-profiles-judges-M.png'))
  end

  def show
    @prosecutor = Prosecutor.find(params[:id])
    if @prosecutor.is_hidden?
      not_found
    end
    @careers = @prosecutor.careers.shown.order_by_publish_at
    @suits = []
    @educations = @prosecutor.educations.shown.order_by_end_at
    @licenses = @prosecutor.licenses.shown.order_by_publish_at
    @newest_award = @prosecutor.awards.shown.order_by_publish_at.first
    @newest_punishments = @prosecutor.punishments.shown.order_by_relevant_date.first(3)
    @newest_reviews = @prosecutor.reviews.shown.had_title.order_by_publish_at.first(3)
    description = ["#{@prosecutor.name}個人資料介紹。"]
    description << "性別#{@prosecutor.gender}、" if @prosecutor.gender.present?
    description << "出生年份#{@prosecutor.birth_year}、" if @prosecutor.birth_year.present?
    description << '現任法官'
    image = @prosecutor.avatar.present? ? @prosecutor.avatar.L_540.url : nil
    set_meta(
      title: { name: @prosecutor.name },
      description: { name: @prosecutor.name },
      keywords: { name: @prosecutor.name },
      image: image
    )
  end
end
