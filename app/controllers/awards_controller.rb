class AwardsController < BaseController
  include OwnerFindingConcern
  before_action :find_owner

  def index
    if @owner.is_hidden?
      not_found
    end
    @awards = @owner.awards.shown.order_by_publish_at.page(params[:page]).per(12)
    @newest_award = @awards.first
    @newest_punishments = @owner.punishments.shown.order_by_relevant_date.first(3)
    @newest_reviews = @owner.reviews.had_title.shown.order_by_publish_at.first(3)
    set_meta(
      title: { name: @owner.name },
      description: { name: @owner.name },
      keywords: { name: @owner.name },
      image: ActionController::Base.helpers.asset_path('hero-profiles-show-M.png')
    )
  end
end
