class Admin::EducationsController < Admin::BaseController
  include OwnerFindingConcern
  before_action :find_owner
  before_action :education
  before_action { add_crumb("#{owner_type}列表", polymorphic_path(@owner.class)) }
  before_action { add_crumb("#{owner_type}檔案 - #{@owner.name}的詳細資料", polymorphic_path(@owner)) }
  before_action(except: [:index]) { add_crumb("#{@owner.name}的學經歷列表", polymorphic_path([@owner, :educations])) }

  def index
    @educations = @owner.educations.all.newest.page(params[:page]).per(10)
    @admin_page_title = "#{@owner.name}的學經歷列表"
    add_crumb @admin_page_title, '#'
  end

  def new
    @admin_page_title = "新增#{@owner.name}的學經歷"
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = "編輯#{@owner.name}的學經歷 - #{education.title}"
    add_crumb @admin_page_title, '#'
  end

  def create
    if education.save
      respond_to do |f|
        f.html { redirect_to polymorphic_path([@owner, :educations]), flash: { success: "#{@owner.name}的學經歷 - #{education.title} 已新增" } }
        f.js { render }
      end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增#{@owner.name}的學經歷"
          add_crumb @admin_page_title, '#'
          flash[:error] = education.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if education.update_attributes(education_params)
      redirect_to polymorphic_path([@owner, :educations]), flash: { success: "#{@owner.name}的學經歷 - #{education.title} 已修改" }
    else
      @admin_page_title = "編輯#{@owner.name}的學經歷 - #{education.title}"
      add_crumb @admin_page_title, '#'
      flash[:error] = education.errors.full_messages
      render :edit
    end
  end

  def destroy
    if education.destroy
      redirect_to polymorphic_path([@owner, :educations]), flash: { success: "#{@owner.name}的學經歷 - #{education.title} 已刪除" }
    else
      flash[:error] = education.errors.full_messages
      redirect_to :back
    end
  end

  private

  def education
    @education ||= params[:id] ? @owner.educations.find(params[:id]) : @owner.educations.new(education_params)
  end

  def education_params
    params.fetch(:education, {}).permit(:owner_id, :owner_type, :title, :content, :start_at_in_tw, :end_at_in_tw, :start_at, :end_at, :source, :memo, :is_hidden)
  end
end
