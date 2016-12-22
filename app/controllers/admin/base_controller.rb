class Admin::BaseController < ApplicationController
  # require 'rails_autolink'
  include CrudConcern

  layout 'admin'
  before_action :authenticate_user!
  before_action :authenticate_admin_user!
  before_action :init_meta, only: [:index]
  before_action do
    add_crumb '首頁', admin_root_path
  end

  def index
    @admin_page_title = '首頁'
  end

  private

  def authenticate_admin_user!
    redirect_to root_path unless current_user.admin?
  end
end
