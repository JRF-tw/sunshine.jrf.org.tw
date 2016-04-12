class Admin::StoriesController < Admin::BaseController

  def index
    @search = Story.all.newest.ransack(params[:q])
    @stories = @search.result.page(params[:page]).per(20)
    @admin_page_title = "案件列表"
    add_crumb @admin_page_title, "#"
  end
end
