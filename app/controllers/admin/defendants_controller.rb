class Admin::DefendantsController < Admin::BaseController
  before_action :defendant
  before_action(except: [:index]){ add_crumb("觀察員列表", admin_defendants_path) }

  def index
    @search = Defendant.all.ransack(params[:q])
    @defendants = @search.result.page(params[:page]).per(20)
    @admin_page_title = "觀察員列表"
    add_crumb @admin_page_title, "#"
  end

  def show
    @admin_page_title = "觀察員檔案 - #{defendant.name} 的詳細資料"
    add_crumb @admin_page_title, "#"
  end

  private

  def defendant
    @defendant ||= params[:id] ? Defendant.find(params[:id]) : Defendant.new
  end
end


