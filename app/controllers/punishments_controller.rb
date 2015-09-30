class PunishmentsController < BaseController
	before_action :get_instances

  def index
    @punishments = @punishments.page(params[:page]).per(12)
    set_meta(
      title: "#{@profile.name}的懲處相關紀錄",
      description: "#{@profile.name}懲處紀錄。",
      keywords: "#{@profile.name}懲處紀錄,#{@profile.name}",
      image: ActionController::Base.helpers.asset_path('hero-profiles-show-M.png')
    )
  end

  def show
  	@punishment = @profile.punishments.find(params[:id])
    set_meta(
      title: "#{@profile.name}的懲處紀錄內容",
      description: "#{@profile.name}懲處內容。",
      keywords: "#{@profile.name}懲處內容,#{@profile.name}",
      image: ActionController::Base.helpers.asset_path('hero-profiles-show-M.png')
    )
  end

  private

  def get_instances
  	@profile = Profile.find(params[:profile_id])
    @punishments = @profile.punishments.order_by_relevant_date
    @newest_award = @profile.awards.order_by_publish_at.first
    @newest_punishments = @punishments.first(3)
    @newest_reviews = @profile.reviews.had_title.order_by_publish_at.first(3)
  end
end
