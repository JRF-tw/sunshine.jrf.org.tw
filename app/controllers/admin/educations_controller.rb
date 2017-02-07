class Admin::EducationsController < Admin::BaseController
  before_action :find_owner
  before_action :education
  before_action { add_crumb("#{owner_type}列表", send("admin_#{owner_pluralize}_path")) }
  before_action { add_crumb("#{owner_type}檔案 - #{@owner.name}的詳細資料", send("admin_#{owner_singularize}_path", @owner.id)) }
  before_action(except: [:index]) { add_crumb("#{@owner.name}的學經歷列表", send("admin_#{owner_singularize}_educations_path", @owner.id)) }

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
        f.html { redirect_to send("admin_#{owner_singularize}_educations_path", @owner), flash: { success: "#{@owner.name}的學經歷 - #{education.title} 已新增" } }
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
      redirect_to send("admin_#{owner_singularize}_educations_path", @owner), flash: { success: "#{@owner.name}的學經歷 - #{education.title} 已修改" }
    else
      @admin_page_title = "編輯#{@owner.name}的學經歷 - #{education.title}"
      add_crumb @admin_page_title, '#'
      flash[:error] = education.errors.full_messages
      render :edit
    end
  end

  def destroy
    if education.destroy
      redirect_to send("admin_#{owner_singularize}_educations_path", @owner), flash: { success: "#{@owner.name}的學經歷 - #{education.title} 已刪除" }
    else
      flash[:error] = education.errors.full_messages
      redirect_to :back
    end
  end

  private

  def find_owner
    @owner_class = Object.const_get(request.env['PATH_INFO'][/admin\/\w+/].singularize.camelize)
    @owner = @owner_class.find(owner_id)
  end

  def education
    @education ||= params[:id] ? @owner.educations.find(params[:id]) : @owner.educations.new(education_params)
  end

  def education_params
    params.fetch(:education, {}).permit(:owner_id, :owner_type, :title, :content, :start_at_in_tw, :end_at_in_tw, :start_at, :end_at, :source, :memo, :is_hidden)
  end

  def owner_type
    case @owner.class.name.demodulize
    when 'Judge'
      '法官'
    when 'Prosecutor'
      '檢察官'
    end
  end

  def owner_id
    params["#{@owner_class.to_s.downcase.demodulize}_id"]
  end

  def owner_pluralize
    @owner_pluralize = @owner.class.to_s.downcase.demodulize.pluralize
  end

  def owner_singularize
    @owner_singularize = @owner.class.to_s.downcase.demodulize.singularize
  end
end
