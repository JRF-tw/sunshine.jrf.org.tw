class PunishmentsController < BaseController
  include OwnerFindingConcern
  before_action :find_owner
  before_action :get_instances

  def index
    @punishments = @punishments.shown.page(params[:page]).per(12)
    set_meta(
      title: { name: @owner.name },
      description: { name: @owner.name },
      keywords: { name: @owner.name },
      image: ActionController::Base.helpers.asset_path('hero-profiles-show-M.png')
    )
  end

  def show
    @punishment = @owner.punishments.find(params[:id])
    if @punishment.is_hidden?
      not_found
    end
    set_meta(
      title: { name: @owner.name },
      description: { name: @owner.name },
      keywords: { name: @owner.name },
      image: ActionController::Base.helpers.asset_path('hero-profiles-show-M.png')
    )
  end

  private

  def get_instances
    if @owner.is_hidden?
      not_found
    end
    @punishments = @owner.punishments.shown.order_by_relevant_date
    @newest_award = @owner.awards.shown.order_by_publish_at.first
    @newest_punishments = @punishments.shown.first(3)
    @newest_reviews = @owner.reviews.shown.had_title.order_by_publish_at.first(3)
  end
end
