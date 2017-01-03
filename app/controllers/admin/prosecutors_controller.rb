class Admin::ProsecutorsController < Admin::BaseController
  before_action :prosecutor
  before_action(except: [:index]) { add_crumb('檢察官列表', admin_prosecutors_path) }

  def index
    @search = Prosecutor.all.includes(:prosecutors_office).ransack(params[:q])
    @prosecutors = @search.result.page(params[:page]).per(20)
    @admin_page_title = '檢察官列表'
    add_crumb @admin_page_title, '#'
  end

  def show
    @admin_page_title = "檢察官檔案 - #{prosecutor.name} 的詳細資料"
    add_crumb @admin_page_title, '#'
  end

  def new
    @admin_page_title = '新增檢察官'
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = "編輯檢察官 - #{prosecutor.name}"
    add_crumb @admin_page_title, '#'
  end

  def create
    context = Admin::ProsecutorCreateContext.new(params)
    if context.perform
      redirect_as_success(admin_prosecutors_path, "檢察官 - #{prosecutor.name} 已新增")
    else
      @prosecutor = context.prosecutor
      @admin_page_title = '新增檢察官'
      add_crumb @admin_page_title, '#'
      render_as_fail(:new, context.error_messages)
    end
  end

  def update
    context = Admin::ProsecutorUpdateContext.new(@prosecutor)
    if context.perform(params)
      redirect_as_success(admin_prosecutors_path, "檢察官 - #{prosecutor.name} 已修改")
    else
      @admin_page_title = "編輯檢察官 - #{prosecutor.name}"
      add_crumb @admin_page_title, '#'
      render_as_fail(:edit, context.error_messages)
    end
  end

  def destroy
    context = Admin::ProsecutorDeleteContext.new(@prosecutor)
    if context.perform
      redirect_as_success(admin_prosecutors_path, "檢察官 - #{prosecutor.name} 已刪除")
    else
      redirect_to :back, flash: { error: context.error_messages }
    end
  end

  def set_to_judge
    context = Admin::JudgeProsecutorToggleContext.new(@prosecutor)
    if context.perform
      redirect_as_success(admin_prosecutor_path, "檢察官 - #{prosecutor.name} 已轉換為法官")
    else
      redirect_to :back, flash: { error: context.error_messages }
    end
  end

  private

  def prosecutor
    @prosecutor ||= params[:id] ? Admin::Prosecutor.find(params[:id]) : Admin::Prosecutor.new
  end
end
