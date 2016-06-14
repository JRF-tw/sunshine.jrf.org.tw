class Admin::BystandersController < Admin::BaseController
  before_action :bystander
  before_action(except: [:index]){ add_crumb("觀察員列表", admin_bystanders_path) }

  def index
    @search = Bystander.all.ransack(params[:q])
    @bystanders = @search.result.page(params[:page]).per(20)
    @admin_page_title = "觀察員列表"
    add_crumb @admin_page_title, "#"
  end

  def show
    @admin_page_title = "觀察員檔案 - #{bystander.name} 的詳細資料"
    add_crumb @admin_page_title, "#"
  end

  def download_file
    @bystanders = Bystander.all
    respond_to do |format| 
      format.xlsx {render xlsx: 'download_file',filename: "旁觀者.xlsx"}
    end
  end

  def send_reset_password_mail
    context = Bystander::SendSetPasswordEmailContext.new(@bystander)
    context.perform
    redirect_as_success(admin_bystanders_path, "重設密碼信件已寄出")
  end

  private

  def bystander
    @bystander ||= params[:id] ? Bystander.find(params[:id]) : Bystander.new
  end
end
