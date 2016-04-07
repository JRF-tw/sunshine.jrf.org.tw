# == Schema Information
#
# Table name: profiles
#
#  id                 :integer          not null, primary key
#  name               :string
#  current            :string
#  avatar             :string
#  gender             :string
#  gender_source      :text
#  birth_year         :integer
#  birth_year_source  :text
#  stage              :integer
#  stage_source       :text
#  appointment        :string
#  appointment_source :text
#  memo               :text
#  created_at         :datetime
#  updated_at         :datetime
#  current_court      :string
#  is_active          :boolean
#  is_hidden          :boolean
#  punishments_count  :integer          default(0)
#  current_department :string
#  current_branch     :string
#

class Admin::ProfilesController < Admin::BaseController
  before_action :profile
  before_action(except: [:index]){ add_crumb("個人檔案列表", admin_profiles_path) }

  def index
    @search = Profile.all.newest.ransack(params[:q])
    @profiles = @search.result.page(params[:page]).per(20)
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
          f.html { redirect_to admin_profile_path(profile), flash: { success: "個人檔案 - #{profile.name} 已新增" } }
          f.js { render }
        end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增個人檔案"
          add_crumb @admin_page_title, "#"
          flash[:error] = profile.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if profile.update_attributes(profile_params)
      redirect_to admin_profile_path(profile), flash: { success: "個人檔案 - #{profile.name} 已修改" }
    else
      @admin_page_title = "編輯個人檔案 - #{profile.name}"
      add_crumb @admin_page_title, "#"
      flash[:error] = profile.errors.full_messages
      render :edit
    end
  end

  def destroy
    if profile.destroy
      redirect_to admin_profiles_path, flash: { success: "個人檔案 - #{profile.name} 已刪除" }
    else
      flash[:error] = profile.errors.full_messages
      redirect_to :back
    end
  end

  private

  def profile
    @profile ||= params[:id] ? Admin::Profile.find(params[:id]) : Admin::Profile.new(profile_params)
  end

  def profile_params
    params.fetch(:admin_profile, {}).permit(:name, :current, :current_court, :avatar, :remove_avatar, :gender, :birth_year, :stage, :appointment, :memo, :gender_source, :birth_year_source, :stage_source, :appointment_source, :is_active, :is_hidden, :current_department, :current_branch)
  end
end
