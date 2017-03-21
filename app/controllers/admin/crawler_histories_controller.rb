class Admin::CrawlerHistoriesController < Admin::BaseController
  def index
    @search = CrawlerHistory.ransack(params[:q])
    @crawler_histories = @search.result.newest.page(params[:page]).per(10)
    @line_chart_scope = @search.result.oldest
    @admin_page_title = '爬蟲紀錄列表'
    add_crumb @admin_page_title, '#'
  end

  def status
    @search = CrawlerHistory.has_referees.newest.ransack(params[:q])
    @crawler_histories = @search.result.page(params[:page]).per(10)
    @admin_page_title = '裁判書抓取數據'
    add_crumb @admin_page_title, '#'
  end

  def highest_judges
    @hash = Redis::HashKey.new('higest_court_judge_created').all
    @admin_page_title = '最高法院法官建立數據'
    add_crumb @admin_page_title, '#'
  end
end
