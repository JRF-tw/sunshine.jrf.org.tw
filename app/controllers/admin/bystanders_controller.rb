class Admin::BystandersController < Admin::BaseController
  before_action :bystander
  before_action(except: [:index]){ add_crumb("觀察員列表", admin_bystanders_path) }

  def index
    @search = Bystander.all.ransack(params[:q])
    @bystanders = @search.result
    respond_to do |format| 
      format.html {
        @admin_page_title = "觀察員列表"
        add_crumb @admin_page_title, "#"
        @bystanders = @bystanders.page(params[:page]).per(20)
      }
      format.xlsx {render xlsx: 'download_file',filename: "旁觀者.xlsx"}
    end
  end

  def show
    @admin_page_title = "觀察員檔案 - #{bystander.name} 的詳細資料"
    add_crumb @admin_page_title, "#"
  end

  private

  def bystander
    @bystander ||= params[:id] ? Bystander.find(params[:id]) : Bystander.new
  end
end
