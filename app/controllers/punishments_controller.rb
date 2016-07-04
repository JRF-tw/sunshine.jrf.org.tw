# == Schema Information
#
# Table name: punishments
#
#  id               :integer          not null, primary key
#  profile_id       :integer
#  decision_unit    :string
#  unit             :string
#  title            :string
#  claimant         :string
#  punish_no        :string
#  decision_no      :string
#  punish_type      :string
#  relevant_date    :date
#  decision_result  :text
#  decision_source  :text
#  reason           :text
#  is_anonymous     :boolean
#  anonymous_source :text
#  anonymous        :string
#  origin_desc      :text
#  proposer         :string
#  plaintiff        :string
#  defendant        :string
#  reply            :text
#  reply_source     :text
#  punish           :text
#  content          :text
#  summary          :text
#  memo             :text
#  created_at       :datetime
#  updated_at       :datetime
#  is_hidden        :boolean
#  status           :text
#

class PunishmentsController < BaseController
  before_action :get_instances

  def index
    @punishments = @punishments.shown.page(params[:page]).per(12)
    set_meta(
      title: "#{@profile.name}的懲處相關紀錄",
      description: "#{@profile.name}懲處紀錄。",
      keywords: "#{@profile.name}懲處紀錄,#{@profile.name}",
      image: ActionController::Base.helpers.asset_path('hero-profiles-show-M.png')
    )
  end

  def show
    @punishment = @profile.punishments.find(params[:id])
    if @punishment.is_hidden?
      not_found
    end
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
    if @profile.is_hidden?
      not_found
    end
    @punishments = @profile.punishments.shown.order_by_relevant_date
    @newest_award = @profile.awards.shown.order_by_publish_at.first
    @newest_punishments = @punishments.shown.first(3)
    @newest_reviews = @profile.reviews.shown.had_title.order_by_publish_at.first(3)
  end
end
