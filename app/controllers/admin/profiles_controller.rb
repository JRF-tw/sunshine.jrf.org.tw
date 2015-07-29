class Admin::ProfilesController < Admin::BaseController
  before_action :profile
  before_action(except: [:index]){ add_crumb("個人檔案列表", admin_profiles_path) }

  def index
    @profiles = Profile.all.page(params[:page]).per(10)
    @admin_page_title = "個人檔案列表"
    add_crumb @admin_page_title, "#"
  end

  def show
    @admin_page_title = "個人檔案 - #{profile.name} 的詳細資料"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "新增個人檔案"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "編輯個人檔案 - #{profile.name}"
    add_crumb @admin_page_title, "#"
  end

  def create
    if profile.save
        respond_to do |f|
          f.html { redirect_to admin_profiles_path, flash: { success: "個人檔案 - #{profile.name} 已新增" } }
          f.js { render }
        end
    else
      respond_to do |f|
        f.html { render :new, flash: { error: profile.errors.full_messages } }
        f.js { render }
      end
    end
  end

  def update
    if profile.update_attributes(profile_params)
      redirect_to admin_profiles_path, flash: { success: "個人檔案 - #{profile.name} 已修改" }
    else
      render :edit, flash: { error: profile.errors.full_messages }
    end
  end

  def destroy
    if profile.destroy
      redirect_to admin_profiles_path, flash: { success: "個人檔案 - #{profile.name} 已刪除" }
    else
      redirect_to :back, flash: { error: profile.errors.full_messages }
    end
  end

  private

  def profile
    @profile ||= params[:id] ? Admin::Profile.find(params[:id]) : Admin::Profile.new(profile_params)
  end

  def profile_params
    params.fetch(:profile, {}).permit(:name, :current, :avatar, :gender, :birth_year, :stage, :appointment, :memo, :gender_source, :birth_year_source, :stage_source, :appointment_source )
  end
end
