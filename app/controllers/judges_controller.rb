class JudgesController < BaseController

  def index
    @judges = Judge.shown.order_by_name.includes(:court).page(params[:page]).per(12)
    set_meta(image: ActionController::Base.helpers.asset_path('hero-profiles-judges-M.png'))
  end

  def show
    @judge = Judge.find(params[:id])
    if @judge.is_hidden?
      not_found
    end
    @careers = @judge.careers.shown.order_by_publish_at
    @educations = @judge.educations.shown.order_by_end_at
    @licenses = @judge.licenses.shown.order_by_publish_at
    @newest_award = @judge.awards.shown.order_by_publish_at.first
    @newest_punishments = @judge.punishments.shown.order_by_relevant_date.first(3)
    @newest_reviews = @judge.reviews.shown.had_title.order_by_publish_at.first(3)
    image = @judge.avatar.present? ? @judge.avatar.L_540.url : nil
    set_meta(
      title: { name: @judge.name },
      description: { name: @judge.name },
      keywords: { name: @judge.name },
      image: image
    )
  end
end
