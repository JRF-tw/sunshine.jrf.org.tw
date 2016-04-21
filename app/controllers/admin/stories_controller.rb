# == Schema Information
#
# Table name: stories
#
#  id            :integer          not null, primary key
#  court_id      :integer
#  main_judge_id :integer
#  story_type    :string
#  year          :integer
#  word_type     :string
#  number        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Admin::StoriesController < Admin::BaseController

  def index
    @search = Story.all.newest.ransack(params[:q])
    @stories = @search.result.page(params[:page]).per(20)
    @admin_page_title = "案件列表"
    add_crumb @admin_page_title, "#"
  end
end
