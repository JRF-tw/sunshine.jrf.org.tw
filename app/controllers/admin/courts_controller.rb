# == Schema Information
#
# Table name: courts
#
#  id         :integer          not null, primary key
#  court_type :string
#  full_name  :string
#  name       :string
#  weight     :integer
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean          default(TRUE)
#  code       :string
#  scrap_name :string
#

class Admin::CourtsController < Admin::BaseController
  before_action :court
  before_action(except: [:index]) { add_crumb("法院 / 檢察署列表", admin_courts_path) }

  def index
    @search = Court.all.newest.ransack(params[:q])
    @courts = @search.result.page(params[:page]).per(20)
    @admin_page_title = "法院 / 檢察署列表"
    add_crumb @admin_page_title, "#"
  end

  def show
    @admin_page_title = "法院 - #{@court.full_name}"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "新增法院 / 檢察署"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "編輯法院 / 檢察署 - #{court.name}"
    add_crumb @admin_page_title, "#"
  end

  def create
    context = Admin::CourtCreateContext.new(params)
    if @court = context.perform
      respond_to do |f|
        f.html { redirect_as_success(admin_courts_path, "法院 / 檢察署 - #{court.name} 已新增") }
        f.js { render }
      end
    else
      @court = context.court
      respond_to do |f|
        f.html {
          new
          render_as_fail(:new, context.error_messages)
        }
        f.js { render }
      end
    end
  end

  def update
    context = Admin::CourtUpdateContext.new(@court)
    if context.perform(params)
      redirect_as_success(admin_courts_path, "法院 / 檢察署 - #{court.name} 已修改")
    else
      render_as_fail(:edit, context.error_messages)
    end
  end

  def destroy
    context = Admin::CourtDeleteContext.new(@court)
    if context.perform
      redirect_as_success(admin_courts_path, "法院 / 檢察署 - #{court.name} 已刪除")
    else
      redirect_to :back, flash: { error: context.error_messages }
    end
  end

  def edit_weight
    @courts = Court.all.get_courts.not_hidden.sorted.page(params[:page]).per(20)
    @admin_page_title = "法院 排序調整"
    add_crumb @admin_page_title, "#"
  end

  def update_weight
    context = Admin::CourtWeightUpdateContext.new(@court)
    if context.perform(params)
      @courts = Court.all.get_courts.not_hidden.sorted.page(params[:page]).per(20)
    else
      @error_messages = context.error_messages
    end
  end

  private

  def court
    @court ||= params[:id] ? Admin::Court.find(params[:id]) : Admin::Court.new
  end

end
