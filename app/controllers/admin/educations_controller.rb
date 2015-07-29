class Admin::EducationsController < Admin::BaseController
  before_action :education
  before_action{ add_crumb("個人檔案列表", admin_profiles_path) }
  before_action{ add_crumb("#{@profile.name}的個人檔案", admin_profile_path(@profile)) }
  before_action(except: [:index]){ add_crumb("#{@profile.name}的學經歷列表", admin_profile_educations_path(@profile)) }

  def index
    @educations = @profile.educations.all.page(params[:page]).per(10)
    @admin_page_title = "#{@profile.name}的學經歷列表"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "新增#{@profile.name}的學經歷"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "編輯#{@profile.name}的學經歷 - #{education.title}"
    add_crumb @admin_page_title, "#"
  end

  def create
    if education.save
        respond_to do |f|
          f.html { redirect_to admin_profile_educations_path(@profile), flash: { success: "#{@profile.name}的學經歷 - #{education.title} 已新增" } }
          f.js { render }
        end
    else
      respond_to do |f|
        f.html { render :new, flash: { error: education.errors.full_messages } }
        f.js { render }
      end
    end
  end

  def update
    if education.update_attributes(education_params)
      redirect_to admin_profile_educations_path(@profile), flash: { success: "#{@profile.name}的學經歷 - #{education.title} 已修改" }
    else
      render :edit, flash: { error: education.errors.full_messages }
    end
  end

  def destroy
    if education.destroy
      redirect_to admin_profile_educations_path(@profile), flash: { success: "#{@profile.name}的學經歷 - #{education.title} 已刪除" }
    else
      redirect_to :back, flash: { error: education.errors.full_messages }
    end
  end

  private

  def education
    @profile = Admin::Profile.find params[:profile_id]
    @education ||= params[:id] ? @profile.educations.find(params[:id]) : @profile.educations.new(education_params)
  end

  def education_params
    params.fetch(:admin_education, {}).permit(:profile_id, :title, :content, :start_at, :end_at, :source, :memo)
  end
end
