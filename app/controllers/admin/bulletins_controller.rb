# == Schema Information
#
# Table name: bulletins
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  pic        :text
#  is_banner  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Admin::BulletinsController < Admin::BaseController
  before_action :bulletin, except: [:index, :new]
  before_action(except: [:index]) { add_crumb('公告訊息管理', admin_bulletins_path) }

  def index
    @search = Admin::Bulletin.all.ransack(params[:q])
    @bulletins = @search.result.page(params[:page]).per(20)
    @admin_page_title = '公告訊息管理'
    add_crumb @admin_page_title, '#'
  end

  def show
    @admin_page_title = "公告訊息 - #{@bulletin.title}"
    add_crumb @admin_page_title, '#'
  end

  def new
    @bulletin = Admin::Bulletin.new
    @admin_page_title = '新增公告訊息'
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = '編輯公告訊息'
    add_crumb @admin_page_title, '#'
  end

  def create
    if bulletin.save
      redirect_as_success(admin_bulletins_path, '公告訊息已新增')
    else
      @admin_page_title = '新增公告訊息'
      add_crumb @admin_page_title, '#'
      render_as_fail(:new, bulletin.errors.full_messages)
    end
  end

  def update
    if bulletin.update_attributes(bulletin_params)
      redirect_as_success(admin_bulletins_path, '公告訊息已修改')
    else
      @admin_page_title = '編輯公告訊息'
      add_crumb @admin_page_title, '#'
      render_as_fail(:edit, bulletin.errors.full_messages)
    end
  end

  def destroy
    if bulletin.destroy
      redirect_as_success(admin_bulletins_path, '公告訊息已刪除')
    else
      redirect_to :back, flash: { error: bulletin.errors.full_messages }
    end
  end

  private

  def bulletin
    @bulletin ||= params[:id] ? Admin::Bulletin.find(params[:id]) : Admin::Bulletin.new(bulletin_params)
  end

  def bulletin_params
    params.require(:admin_bulletin).permit(:title, :content, :pic, :is_banner, :remove_pic)
  end
end
