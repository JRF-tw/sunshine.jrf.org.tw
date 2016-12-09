# == Schema Information
#
# Table name: prosecutors_offices
#
#  id         :integer          not null, primary key
#  full_name  :string
#  name       :string
#  court_id   :integer
#  is_hidden  :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Admin::ProsecutorsOfficesController < Admin::BaseController
  before_action :prosecutors_office
  before_action(except: [:index]) { add_crumb('檢察署列表', admin_prosecutors_offices_path) }

  def index
    @search = ProsecutorsOffice.all.newest.ransack(params[:q])
    @prosecutors_offices = @search.result.page(params[:page]).per(20)
    @admin_page_title = '檢察署列表'
    add_crumb @admin_page_title, '#'
  end

  def show
    @admin_page_title = "檢察署 - #{@prosecutors_office.full_name}"
    add_crumb @admin_page_title, '#'
  end

  def new
    @admin_page_title = '新增檢察署'
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = "編輯檢察署 - #{prosecutors_office.name}"
    add_crumb @admin_page_title, '#'
  end

  def create
    context = Admin::ProsecutorsOfficeCreateContext.new(params)
    if context.perform
      redirect_as_success(admin_prosecutors_offices_path, "檢察署 - #{prosecutors_office.name} 已新增")
    else
      @prosecutors_office = context.prosecutors_office
      render_as_fail(:new, context.error_messages)
    end
  end

  def update
    context = Admin::ProsecutorsOfficeUpdateContext.new(@prosecutors_office)
    if context.perform(params)
      redirect_as_success(admin_prosecutors_offices_path, "檢察署 - #{prosecutors_office.name} 已修改")
    else
      render_as_fail(:edit, context.error_messages)
    end
  end

  def destroy
    context = Admin::ProsecutorsOfficeDeleteContext.new(@prosecutors_office)
    if context.perform
      redirect_as_success(admin_prosecutors_offices_path, "檢察署 - #{prosecutors_office.name} 已刪除")
    else
      redirect_to :back, flash: { error: context.error_messages }
    end
  end

  private

  def prosecutors_office
    @prosecutors_office ||= params[:id] ? Admin::ProsecutorsOffice.find(params[:id]) : Admin::ProsecutorsOffice.new
  end

end
