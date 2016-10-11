# == Schema Information
#
# Table name: lawyers
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  current                :string
#  avatar                 :string
#  gender                 :string
#  birth_year             :integer
#  memo                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           not null
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  last_sign_in_at        :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmation_sent_at   :datetime
#  confirmed_at           :datetime
#  unconfirmed_email      :string
#  phone_number           :string
#  office_number          :string
#

class Admin::LawyersController < Admin::BaseController
  before_action :lawyer
  before_action(except: [:index]) { add_crumb("律師列表", admin_lawyers_path) }

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
    context =  Admin::LawyerCreateContext.new(params)
    if @lawyer = context.perform
      redirect_as_success(admin_lawyer_path(@lawyer), "律師 - #{lawyer.name} 已新增")
    else
      @lawyer = context.lawyer
      render_as_fail(:new, context.error_messages)
    end
  end

  def update
    context = Admin::LawyerUpdateContext.new(@lawyer)
    if context.perform(params)
      redirect_as_success(admin_lawyers_path, "律師 - #{lawyer.name} 已修改")
    else
      render_as_fail(:edit, context.error_messages)
    end
  end

  def destroy
    context = Admin::LawyerDeleteContext.new(@lawyer)
    if context.perform
      redirect_as_success(admin_lawyers_path, "律師 - #{lawyer.name} 已刪除")
    else
      redirect_to :back, flash: { error: context.error_messages }
    end
  end

  def send_reset_password_mail
    context = Lawyer::SendSetPasswordEmailContext.new(@lawyer)
    context.perform
    redirect_as_success(admin_lawyers_path, "律師 - #{lawyer.name} 重設密碼信件已寄出")
  end

  private

  def lawyer
    @lawyer ||= params[:id] ? Admin::Lawyer.find(params[:id]) : Admin::Lawyer.new
  end
end
