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
