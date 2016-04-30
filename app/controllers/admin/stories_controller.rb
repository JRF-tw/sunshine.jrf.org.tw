# == Schema Information
#
# Table name: stories
#
#  id               :integer          not null, primary key
#  court_id         :integer
#  main_judge_id    :integer
#  story_type       :string
#  year             :integer
#  word_type        :string
#  number           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  defendant_names  :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  is_adjudge       :boolean          default(FALSE)
#

class Admin::StoriesController < Admin::BaseController
  before_action :story, :except => [:index]

  def index
    @search = Story.all.newest.ransack(params[:q])
    @stories = @search.result.page(params[:page]).per(20)
    @admin_page_title = "案件列表"
    add_crumb @admin_page_title, "#"
  end

  def show
    @admin_page_title = "案件 - #{@story.identity}"
    add_crumb @admin_page_title, "#"
  end

  private

  def story
    @story = Admin::Story.find(params[:id])
  end

end
