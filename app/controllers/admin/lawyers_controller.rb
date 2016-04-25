# == Schema Information
#
# Table name: lawyers
#
#  id         :integer          not null, primary key
#  name       :string
#  current    :string
#  avatar     :string
#  gender     :string
#  birth_year :integer
#  memo       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Admin::LawyersController < Admin::BaseController
  before_action :lawyer
  before_action(except: [:index]){ add_crumb("律師列表", admin_lawyers_path) }

  def index
    @search = Admin::Lawyer.all.ransack(params[:q])
    @lawyers = @search.result.page(params[:page]).per(20)
    @admin_page_title = "律師列表"
    add_crumb @admin_page_title, "#"
  end

  def show
    @admin_page_title = "律師檔案 - #{lawyer.name} 的詳細資料"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "新增律師"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "編輯律師 - #{lawyer.name}"
    add_crumb @admin_page_title, "#"
  end

  def create
    context = LawyerCreateContext.new(params)
    if @lawyer = context.perform
      redirect_as_success(admin_lawyers_path,  "律師 - #{lawyer.name} 已新增")
    else
      @lawyer = context.lawyer
      render_as_fail(:new, context.error_messages)
    end  
  end

  def update
    context = LawyerUpdateContext.new(@lawyer)
    if context.perform(params)
      redirect_as_success(admin_lawyers_path, "律師 - #{lawyer.name} 已修改")
    else
      render_as_fail(:edit, context.error_messages) 
    end
  end

  def destroy
    context = LawyerDeleteContext.new(@lawyer)
    if context.perform
      redirect_as_success(admin_lawyers_path, "律師 - #{lawyer.name} 已刪除")
    else
      redirect_to :back, flash: { error: context.error_messages.join(", ") }
    end
  end


  private

  def lawyer
    @lawyer ||= params[:id] ? Admin::Lawyer.find(params[:id]) : Admin::Lawyer.new
  end
end
