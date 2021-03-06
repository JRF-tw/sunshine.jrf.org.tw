class Admin::CrawlerLogsController < Admin::BaseController
  before_action :crawler_history
  before_action :crawler_log, only: [:show]
  before_action { add_crumb('爬蟲紀錄列表', admin_crawler_histories_path) }

  def show
    @admin_page_title = "#{@crawler_history.crawler_on} - #{CrawlerKinds.list[@crawler_log.crawler_kind.to_sym]} - #{CrawlerErrorTypes.list[@crawler_log.crawler_error_type.to_sym]}"
    add_crumb @admin_page_title, '#'
  end

  def pie_chart
    @admin_page_title = "爬蟲紀錄 - #{@crawler_history.crawler_on} 錯誤圓餅圖"
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
