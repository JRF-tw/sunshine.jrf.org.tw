class PunishmentsController < BaseController
  before_action :get_instances

  def index
    @punishments = @punishments.shown.page(params[:page]).per(12)
    set_meta(
      title: { name: @profile.name },
      description: { name: @profile.name },
      keywords: { name: @profile.name },
      image: ActionController::Base.helpers.asset_path('hero-profiles-show-M.png')
    )
  end

  def show
    @punishment = @profile.punishments.find(params[:id])
    if @punishment.is_hidden?
      not_found
    end
    set_meta(
      title: { name: @profile.name },
      description: { name: @profile.name },
      keywords: { name: @profile.name },
      image: ActionController::Base.helpers.asset_path('hero-profiles-show-M.png')
    )
  end

  private

  def get_instances
    @profile = Profile.find(params[:profile_id])
    if @profile.is_hidden?
      not_found
    end
    @punishments = @profile.punishments.shown.order_by_relevant_date
    @newest_award = @profile.awards.shown.order_by_publish_at.first
    @newest_punishments = @punishments.shown.first(3)
    @newest_reviews = @profile.reviews.shown.had_title.order_by_publish_at.first(3)
  end
end
