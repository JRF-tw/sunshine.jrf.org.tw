class Admin::StoriesController < Admin::BaseController
  before_action :story, except: [:index]
  before_action(except: [:index]) { add_crumb('案件列表', admin_stories_path) }

  def index
    # rubocop:disable AsciiComments TODO拿掉此頁面routes view一併移除
    @search = Story.all.newest.ransack(params[:q])
    @stories = @search.result.page(params[:page]).per(20)
    @admin_page_title = '案件列表'
    add_crumb @admin_page_title, '#'
  end

  def show
    @admin_page_title = "案件 - #{@story.identity}"
    add_crumb @admin_page_title, '#'
  end

  private

  def story
    @story = Admin::Story.find(params[:id])
  end

end
