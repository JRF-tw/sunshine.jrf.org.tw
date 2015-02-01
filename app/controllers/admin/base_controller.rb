class Admin::BaseController < ApplicationController
  layout 'admin'

  def index
    @admin_page_title = "Admin"
  end
end
