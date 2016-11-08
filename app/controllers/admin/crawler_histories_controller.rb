class Admin::CrawlerHistoriesController < Admin::BaseController
  def index
    @search = CrawlerHistory.newest.ransack(params[:q])
    @crawler_histories = @search.result.page(params[:page]).per(10)
    @admin_page_title = '爬蟲紀錄列表'
    add_crumb @admin_page_title, '#'
  end
end
