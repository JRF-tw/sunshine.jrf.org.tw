class BaseController < ApplicationController
  # rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  # rescue_from ActionView::MissingTemplate do |exception|
  #   render nothing: true, status: 404
  # end
  before_action :http_auth_for_production, only: [:who_are_you, :score_intro, :terms_of_service, :privacy]
  before_action :init_meta, only: [:who_are_you, :score_intro, :terms_of_service, :privacy]

  def index
    @banners = Banner.shown.order_by_weight
    @bulletins = Bulletin.most_recent(6)
    @suits = Suit.shown.last(3)
    @judges = Profile.judges.shown.active.had_avatar.sample(12)
    @prosecutors = Profile.prosecutors.shown.active.had_avatar.sample(12)
    image = @banners.count > 0 ? @banners.first.pic.W_1296.url : nil
    set_meta(image: image)
  end

  def about
    set_meta(image: ActionController::Base.helpers.asset_path('hero-base-about-M.png'))
  end

  def who_are_you
  end

  def score_intro
  end

  def terms_of_service
  end

  def privacy
  end

  def render_404
    # render :not_found, status: 404
    redirect_to root_path
  end

  private

  def init_meta
    set_meta
  end
end
