class Admin::BannersController < Admin::BaseController
  before_action :banner
  before_action(except: [:index]) { add_crumb('首頁橫幅列表', admin_banners_path) }

  def index
    @banners = Admin::Banner.all.order_by_weight.page(params[:page]).per(10)
    @admin_page_title = '首頁橫幅列表'
    add_crumb @admin_page_title, '#'
  end

  def new
    @admin_page_title = '新增首頁橫幅'
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = '編輯首頁橫幅'
    add_crumb @admin_page_title, '#'
  end

  def create
    if banner.save
      respond_to do |f|
        f.html { redirect_to admin_banners_path, flash: { success: '首頁橫幅已新增' } }
        f.js { render }
      end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = '新增首頁橫幅'
          add_crumb @admin_page_title, '#'
          flash[:error] = banner.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if banner.update_attributes(banner_params)
      redirect_to admin_banners_path, flash: { success: '首頁橫幅已修改' }
    else
      @admin_page_title = '編輯首頁橫幅'
      add_crumb @admin_page_title, '#'
      flash[:error] = banner.errors.full_messages
      render :edit
    end
  end

  def destroy
    if banner.destroy
      redirect_to admin_banners_path, flash: { success: '首頁橫幅已刪除' }
    else
      flash[:error] = banner.errors.full_messages
      redirect_to :back
    end
  end

  private

  def banner
    @banner ||= params[:id] ? Admin::Banner.find(params[:id]) : Admin::Banner.new(banner_params)
  end

  def banner_params
    params.fetch(:admin_banner, {}).permit(:title, :desc, :link, :btn_wording, :pic_l, :pic_m, :pic_s, :weight, :is_hidden)
  end
end
