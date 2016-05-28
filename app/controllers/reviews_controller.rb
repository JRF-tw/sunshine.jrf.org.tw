# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  publish_at :date
#  name       :string
#  title      :string
#  content    :text
#  comment    :text
#  no         :string
#  source     :text
#  file       :string
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean
#

class ReviewsController < BaseController
  def index
    @profile = Profile.find(params[:profile_id])
    if @profile.is_hidden?
      not_found
    end
    @reviews = @profile.reviews.shown.had_title.order_by_publish_at.page(params[:page]).per(12)
    @newest_award = @profile.awards.shown.order_by_publish_at.first
    @newest_punishments = @profile.punishments.shown.order_by_relevant_date.first(3)
    @newest_reviews = @reviews.shown.first(3)
    set_meta(
      title: "#{@profile.name}的相關新聞紀錄",
      description: "#{@profile.name}的新聞相關清單。",
      keywords: "#{@profile.name}相關新聞,#{@profile.name}",
      image: ActionController::Base.helpers.asset_path('hero-profiles-show-M.png')
    )
  end
end
