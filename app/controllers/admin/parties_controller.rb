class Admin::PartiesController < Admin::BaseController
  before_action :party
  before_action(except: [:index]) { add_crumb("當事人列表", admin_parties_path) }

  def index
    @search = Party.all.ransack(params[:q])
    @parties = @search.result.page(params[:page]).per(20)
    @admin_page_title = "當事人列表"
    add_crumb @admin_page_title, "#"
  end

  def show
    @admin_page_title = "當事人檔案 - #{party.name} 的詳細資料"
    add_crumb @admin_page_title, "#"
  end

  def set_to_imposter
    context = Party::SetToImpostorContext.new(@party)
    if context.perform
      redirect_to admin_parties_path, flash: { success: "當事人 #{@party.name} 已設定為冒用者" }
    else
      redirect_to admin_parties_path, flash: { error: context.error_messages }
    end
  end

  private

  def party
    @party ||= params[:id] ? Party.find(params[:id]) : Party.new
  end
end
