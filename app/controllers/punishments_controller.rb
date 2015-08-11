class PunishmentsController < BaseController
  def index
    @profile = Profile.find(params[:profile_id])
    set_meta(title: "#{@profile.name}的懲處相關紀錄")
  end

  def show
    @profile = Profile.find(params[:profile_id])
    @punishment = @profile.punishments.find(params[:id])
    set_meta(title: "#{@profile.name}的懲處相關紀錄內容")
  end
end
