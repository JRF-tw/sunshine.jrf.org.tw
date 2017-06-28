class Admin::ObserversController < Admin::BaseController
  before_action :court_observer
  before_action(except: [:index]) { add_crumb('觀察員列表', admin_observers_path) }

  def index
    @search = CourtObserver.all.ransack(params[:q])
    @court_observers = @search.result
    respond_to do |format|
      format.html {
        @admin_page_title = '觀察員列表'
        add_crumb @admin_page_title, '#'
        @court_observers = @court_observers.page(params[:page]).per(20)
      }
      format.xlsx { render xlsx: 'download_file', filename: '旁觀者.xlsx' }
    end
  end

  def show
    @admin_page_title = "觀察員檔案 - #{court_observer.name} 的詳細資料"
    add_crumb @admin_page_title, '#'
  end

  def school_export
    @search = CourtObserver.all.ransack(params[:q])
    @court_observers = @search.result
    respond_to do |format|
      format.xlsx { render xlsx: 'school_export', filename: '學生旁觀者.xlsx' }
    end
  end

  private

  def court_observer
    @court_observer ||= params[:id] ? CourtObserver.find(params[:id]) : CourtObserver.new
  end
end
