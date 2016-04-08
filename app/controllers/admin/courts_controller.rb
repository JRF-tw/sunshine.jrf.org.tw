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
#  is_hidden  :boolean
#  code       :string
#

class Admin::CourtsController < Admin::BaseController
  before_action :find_court
  before_action(except: [:index]){ add_crumb("法院 / 檢察署列表", admin_courts_path) }

  def index
    @search = Court.all.newest.ransack(params[:q])
    @courts = @search.result.page(params[:page]).per(20)
    @admin_page_title = "法院 / 檢察署列表"
    add_crumb @admin_page_title, "#"
  end

  def new
    @court ||= Admin::Court.new 
    @admin_page_title = "新增法院 / 檢察署"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "編輯法院 / 檢察署 - #{@court.name}"
    add_crumb @admin_page_title, "#"
  end

  def create
    context = CourtCreateContext.new(params)
    if @court = context.perform
        respond_to do |f|
          f.html { redirect_as_success(admin_courts_path, "法院 / 檢察署 - #{@court.name} 已新增") }
          f.js { render }
        end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增法院 / 檢察署"
          add_crumb @admin_page_title, "#"
          render_as_fail(:new, context.error_messages)
        }
        f.js { render }
      end
    end
  end

  def update
    context = CourtUpdateContext.new(@court)
    if context.perform(params)
      redirect_as_success(admin_courts_path, "法院 / 檢察署 - #{@court.name} 已修改")
    else
      @admin_page_title = "編輯法院 / 檢察署 - #{@court.name}"
      add_crumb @admin_page_title, "#"
      render_as_fail(:edit, context.error_messages) 
    end
  end

  def destroy
    context = CourtDeleteContext.new(@court)
    if context.perform
      redirect_as_success(admin_courts_path, "法院 / 檢察署 - #{@court.name} 已刪除")
    else
      redirect_to :back, flash: { error: context.error_messages.join(", ") }
    end
  end

  private

  def find_court
    @court ||=  Admin::Court.find(params[:id]) if params[:id]
  end
  
end
