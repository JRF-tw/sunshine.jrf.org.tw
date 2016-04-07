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
  before_action :court
  before_action(except: [:index]){ add_crumb("法院 / 檢察署列表", admin_courts_path) }

  def index
    @courts = Court.all.newest.page(params[:page]).per(20)
    @admin_page_title = "法院 / 檢察署列表"
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
    if court.save
        respond_to do |f|
          f.html { redirect_to admin_courts_path, flash: { success: "法院 / 檢察署 - #{court.name} 已新增" } }
          f.js { render }
        end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = "新增法院 / 檢察署"
          add_crumb @admin_page_title, "#"
          flash[:error] = court.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if court.update_attributes(court_params)
      redirect_to admin_courts_path, flash: { success: "法院 / 檢察署 - #{court.name} 已修改" }
    else
      @admin_page_title = "編輯法院 / 檢察署 - #{court.name}"
      add_crumb @admin_page_title, "#"
      flash[:error] = court.errors.full_messages
      render :edit
    end
  end

  def destroy
    if court.destroy
      redirect_to admin_courts_path, flash: { success: "法院 / 檢察署 - #{court.name} 已刪除" }
    else
      flash[:error] = court.errors.full_messages
      redirect_to :back
    end
  end

  private

  def court
    @court ||= params[:id] ? Admin::Court.find(params[:id]) : Admin::Court.new(court_params)
  end

  def court_params
    params.fetch(:admin_court, {}).permit(:court_type, :full_name, :name, :weight, :is_hidden)
  end
end
