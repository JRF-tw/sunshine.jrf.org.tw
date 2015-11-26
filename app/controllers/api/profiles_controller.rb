class Api::ProfilesController < BaseController
  def index
    limit = params[:limit].blank? ? 10 : params[:limit]
    ransack_params = {}
    ransack_params[:name_cont] = params[:query] if params[:query]
    if ransack_params.blank?
      @profiles = Profile.includes(:punishments, :awards, :careers, :educations, :licenses).shown.offset(params[:offset]).limit(limit)
      @profiles_count = Profile.shown.count
    else
      @profiles = Profile.includes(:punishments, :awards, :careers, :educations, :licenses).shown.ransack(ransack_params).result(distinct: true)
        .offset(params[:offset]).limit(limit)
      @profiles_count = Profile.ransack(ransack_params).result(distinct: true).shown.count
    end
    respond_with(@profiles, @profiles_count)
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def judges
    limit = params[:limit].blank? ? 10 : params[:limit]
    ransack_params = {}
    ransack_params[:name_cont] = params[:query] if params[:query]
    if ransack_params.blank?
      @profiles = Profile.includes(:punishments, :awards, :careers, :educations, :licenses).judges.shown.offset(params[:offset]).limit(limit)
      @profiles_count = Profile.count
    else
      @profiles = Profile.includes(:punishments, :awards, :careers, :educations, :licenses).judges.shown.ransack(ransack_params).result(distinct: true)
        .offset(params[:offset]).limit(limit)
      @profiles_count = Profile.ransack(ransack_params).result(distinct: true).count
    end
    respond_with(@profiles, @profiles_count)
  end

  def prosecutors
    limit = params[:limit].blank? ? 10 : params[:limit]
    ransack_params = {}
    ransack_params[:name_cont] = params[:query] if params[:query]
    if ransack_params.blank?
      @profiles = Profile.includes(:punishments, :awards, :careers, :educations, :licenses).prosecutors.shown.offset(params[:offset]).limit(limit)
      @profiles_count = Profile.prosecutors.shown.count
    else
      @profiles = Profile.includes(:punishments, :awards, :careers, :educations, :licenses).prosecutors.shown.ransack(ransack_params).result(distinct: true)
        .offset(params[:offset]).limit(limit)
      @profiles_count = Profile.ransack(ransack_params).result(distinct: true).prosecutors.shown.count
    end
    respond_with(@profiles, @profiles_count)
  end
end