class Admin::BulletinsController < Admin::BaseController
  before_action :bulletin
  before_action(except: [:index]) { add_crumb('公告訊息管理', admin_bulletins_path) }

  def index
    @bulletins = Bulletin.all.page(params[:page]).per(10)
    @admin_page_title = '公告訊息管理'
    add_crumb @admin_page_title, '#'
  end

  def new
    @admin_page_title = '新增公告訊息'
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = '編輯公告訊息'
    add_crumb @admin_page_title, '#'
  end

  def create
    if bulletin.save
      respond_to do |f|
        f.html { redirect_to admin_bulletins_path, flash: { success: '公告訊息已新增' } }
        f.js { render }
      end
    else
      respond_to do |f|
        f.html {
          @admin_page_title = '新增公告訊息'
          add_crumb @admin_page_title, '#'
          flash[:error] = bulletin.errors.full_messages
          render :new
        }
        f.js { render }
      end
    end
  end

  def update
    if bulletin.update_attributes(bulletin_params)
      redirect_to admin_bulletins_path, flash: { success: '公告訊息已修改' }
    else
      @admin_page_title = '編輯公告訊息'
      add_crumb @admin_page_title, '#'
      flash[:error] = bulletin.errors.full_messages
      render :edit
    end
  end

  def destroy
    if bulletin.destroy
      redirect_to admin_bulletins_path, flash: { success: '公告訊息已刪除' }
    else
      flash[:error] = bulletin.errors.full_messages
      redirect_to :back
    end
  end

  private

  def bulletin
    @bulletin ||= params[:id] ? Admin::Bulletin.find(params[:id]) : Admin::Bulletin.new(bulletin_params)
  end

  def bulletin_params
    params.fetch(:admin_bulletin, {}).permit(:title, :content, :pic, :is_hidden)
  end
end
