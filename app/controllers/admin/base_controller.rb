class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  before_filter :authenticate_admin_user!
  before_filter do
    add_crumb "首頁", admin_root_path
  end

  def index
    @admin_page_title = "首頁"
    set_meta(title: "首頁")
  end

  private

  def authenticate_admin_user!
    redirect_to root_path unless current_user.admin?
  end
end
