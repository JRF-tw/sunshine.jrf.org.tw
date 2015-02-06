class Admin::UsersController < Admin::BaseController
  before_filter :user
  before_filter(except: [:index]){ add_crumb("Users", admin_users_path) }

  def index
    @users = User.all.page(params[:page]).per(10)
    @admin_page_title = "Users"
    add_crumb @admin_page_title, "#"
  end

  def show
    @admin_page_title = "##{user.id}"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "New User"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "Edit User"
    add_crumb @admin_page_title, "#"
  end

  def create
    if user.save
      redirect_to admin_user_path(user), flash: { success: "user created" }
    else
      render :new, flash: { error: user.errors.full_messages }
    end
  end

  def update
    if user.update_attributes(user_params)
      redirect_to admin_user_path(user), flash: { success: "user updated" }
    else
      render :edit, flash: { error: user.errors.full_messages }
    end
  end

  def destroy
    if user.destroy
      redirect_to admin_users_path, flash: { success: "user deleted" }
    else
      redirect_to :back, flash: { error: user.errors.full_messages }
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
