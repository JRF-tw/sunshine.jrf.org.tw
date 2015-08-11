class ProfilesController < BaseController
  def judges
    set_meta(title: "認識法官")
  end

  def prosecutors
    set_meta(title: "認識檢察官")
  end

  def show
    @profile = Profile.find(params[:id])
    set_meta(title: "#{@profile.name}的個人頁")
  end
end
