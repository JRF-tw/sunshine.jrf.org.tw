class ReviewsController < BaseController
  def index
    @profile = Profile.find(params[:profile_id])
    set_meta(title: "#{@profile.name}的相關新聞記錄")
  end
end
