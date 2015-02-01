class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  before_filter :authenticate_admin_user!

  def index
    @admin_page_title = "Admin"
  end

  private

  def authenticate_admin_user!
    redirect_to root_path unless current_user.admin?
  end
end
