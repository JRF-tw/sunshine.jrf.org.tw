class Admin::SchedulesController < Admin::BaseController
  before_action :schedule
  before_action :find_story_by_ransack_search, only: [:index]
  before_action(except: [:index]) { add_crumb('庭期列表', admin_schedules_path) }

  def index
    @search = Schedule.includes(:branch_judge).newest.ransack(params[:q])
    @schedules = @search.result.includes(:court, :story).page(params[:page]).per(20)
    @admin_page_title = @story ? "案件 #{@story.identity} 的庭期表" : '庭期表列表'
    add_crumb @admin_page_title, '#'
  end

  def show
    @admin_page_title = "#{@schedule.court.name}-#{@schedule.story.identity} 庭期表"
    add_crumb @admin_page_title, '#'
  end

  private

  def find_story_by_ransack_search
    return @story = Story.find(params[:q][:story_id_eq]) if params[:q].try { |q| q.include?(:story_id_eq) }
  end

  def schedule
    @schedule ||= params[:id] ? Admin::Schedule.find(params[:id]) : Admin::Schedule.new
  end
end
