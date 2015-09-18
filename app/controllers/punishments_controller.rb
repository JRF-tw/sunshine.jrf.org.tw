class PunishmentsController < BaseController
	before_action :get_instances

  def index
    set_meta(title: "#{@profile.name}的懲處相關紀錄")
  end

  def show
  	@punishment = @profile.punishments.find(params[:id])
    set_meta(title: "#{@profile.name}的懲處相關紀錄內容")
  end

  private

  def get_instances
  	@profile = Profile.find(params[:profile_id])
    @newest_award = @profile.awards.newest.last
    @punishments = @profile.punishments.newest
    @newest_punishments = @punishments.first(3)
    @newest_reviews = @profile.reviews.had_title.newest.first(3)
  end
end
