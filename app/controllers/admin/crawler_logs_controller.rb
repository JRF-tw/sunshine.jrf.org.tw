class Admin::CrawlerLogsController < Admin::BaseController
  before_action :crawler_history
  before_action :crawler_log, only: [:show]

  def index
    @search = @crawler_history.crawler_logs.ransack(params[:q])
    @crawler_logs = @search.result.page(params[:page]).per(10)
    @admin_page_title = "爬蟲紀錄 - #{@crawler_history.crawler_on} 列表"
    add_crumb @admin_page_title, '#'
  end

  def show
    @admin_page_title = "#{@crawler_history.crawler_on} - #{CrawlerKinds.list[@crawler_log.crawler_kind.to_sym]} - #{CrawlerErrorTypes.list[@crawler_log.crawler_error_type.to_sym]}"
    add_crumb @admin_page_title, '#'
  end

  private

  def crawler_history
    @crawler_history = CrawlerHistory.find params[:crawler_history_id]
  end

  def crawler_log
    @crawler_log = @crawler_history.crawler_logs.find(params[:id])
  end
end
