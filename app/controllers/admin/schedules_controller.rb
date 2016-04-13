# == Schema Information
#
# Table name: schedules
#
#  id          :integer          not null, primary key
#  story_id    :integer
#  court_id    :integer
#  branch_name :string
#  date        :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Admin::SchedulesController < Admin::BaseController

  def index
    @search = Schedule.all.newest.ransack(params[:q])
    @schedules = @search.result.page(params[:page]).per(20)
    @admin_page_title = "庭期表列表"
    add_crumb @admin_page_title, "#"
  end

end
