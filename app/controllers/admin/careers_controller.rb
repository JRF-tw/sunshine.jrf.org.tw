class Admin::CareersController < Admin::BaseController
  before_action :career
  before_action { add_crumb('個人檔案列表', admin_profiles_path) }
  before_action { add_crumb("#{@profile.name}的個人檔案", admin_profile_path(@profile)) }
  before_action(except: [:index]) { add_crumb("#{@profile.name}的職務經歷列表", admin_profile_careers_path(@profile)) }

  def index
    @careers = @profile.careers.all.order_by_publish_at.page(params[:page]).per(10)
    @admin_page_title = "#{@profile.name}的職務經歷列表"
    add_crumb @admin_page_title, '#'
  end

  def new
    @admin_page_title = "新增#{@profile.name}的職務經歷"
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = "編輯#{@profile.name}的職務經歷"
    add_crumb @admin_page_title, '#'
  end

  def create
    if career.save
      respond_to do |f|
        f.html { redirect_to admin_profile_careers_path(@profile), flash: { success: "#{@profile.name}的職務經歷 - 已新增" } }
        f.js { render }
      end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增#{@profile.name}的職務經歷"
          add_crumb @admin_page_title, '#'
          flash[:error] = career.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if career.update_attributes(career_params)
      redirect_to admin_profile_careers_path(@profile), flash: { success: "#{@profile.name}的職務經歷 - 已修改" }
    else
      @admin_page_title = "編輯#{@profile.name}的職務經歷"
      add_crumb @admin_page_title, '#'
      flash[:error] = career.errors.full_messages
      render :edit
    end
  end

  def destroy
    if career.destroy
      redirect_to admin_profile_careers_path(@profile), flash: { success: "#{@profile.name}的職務經歷 - 已刪除" }
    else
      flash[:error] = career.errors.full_messages
      redirect_to :back
    end
  end

  private

  def career
    @profile = Admin::Profile.find params[:profile_id]
    @career ||= params[:id] ? @profile.careers.find(params[:id]) : @profile.careers.new(career_params)
  end

  def career_params
    params.fetch(:admin_career, {}).permit(:profile_id, :career_type, :old_unit, :old_title, :old_assign_court, :old_assign_judicial, :old_pt, :new_unit, :new_title, :new_assign_court, :new_assign_judicial, :new_pt, :start_at, :end_at, :publish_at, :start_at_in_tw, :end_at_in_tw, :publish_at_in_tw, :source, :source_link, :origin_desc, :memo, :is_hidden)
  end
end
