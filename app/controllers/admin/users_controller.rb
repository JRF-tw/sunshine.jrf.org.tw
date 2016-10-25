# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
#

class Admin::UsersController < Admin::BaseController
  before_action :user
  before_action(except: [:index]) { add_crumb('後台使用者列表', admin_users_path) }

  def index
    @users = User.all.page(params[:page]).per(10)
    @admin_page_title = '後台使用者列表'
    add_crumb @admin_page_title, '#'
  end

  def show
    @admin_page_title = "後台使用者 - #{user.name} 的資訊"
    add_crumb @admin_page_title, '#'
  end

  def new
    @admin_page_title = '新增後台使用者'
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = "編輯後台使用者 - #{user.name}"
    add_crumb @admin_page_title, '#'
  end

  def create
    if user.save
      redirect_to admin_user_path(user), flash: { success: "後台使用者 - #{user.name} 已新增" }
    else
      @admin_page_title = '新增後台使用者'
      add_crumb @admin_page_title, '#'
      flash[:error] = user.errors.full_messages
      render :new
    end
  end

  def update
    if user.update_attributes(user_params)
      redirect_to admin_user_path(user), flash: { success: "後台使用者 - #{user.name} 已修改" }
    else
      @admin_page_title = "編輯後台使用者 - #{user.name}"
      add_crumb @admin_page_title, '#'
      flash[:error] = user.errors.full_messages
      render :edit
    end
  end

  def destroy
    if user.destroy
      redirect_to admin_users_path, flash: { success: "後台使用者 - #{user.name} 已刪除" }
    else
      flash[:error] = user.errors.full_messages
      redirect_to :back
    end
  end

  private

  def user
    @user ||= params[:id] ? Admin::User.find(params[:id]) : Admin::User.new(user_params)
  end

  def user_params
    params.fetch(:user, {}).permit(:name, :email, :password, :admin)
  end
end
