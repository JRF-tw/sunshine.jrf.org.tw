class CourtObservers::StoriesController < CourtObservers::BaseController
  layout "observer"
  before_action :find_story, only: [:show]
  before_action :has_score?, only: [:show]

  def index
    @stories = ::CourtObserverQueries.new(current_court_observer).get_stories
    # meta
    set_meta(
      title: "觀察者案件列表頁",
      description: "觀察者案件列表頁",
      keywords: "觀察者案件列表頁"
    )
  end

  def show
    @pending_score_schedules = ::CourtObserverQueries.new(current_court_observer).pending_score_schedules(@story)
    # meta
    set_meta(
      title: "觀察者 案件-#{@story.identity} 資訊頁",
      description: "觀察者 案件-#{@story.identity} 資訊頁",
      keywords: "觀察者 案件-#{@story.identity} 資訊頁"
    )
  end

  private

  def find_story
    # TODO: security issue
    @story = begin
               Story.find(params[:id])
             rescue
               nil
             end
    redirect_as_fail(court_observer_root_path, "找不到該案件") unless @story
  end

  def has_score?
    @scores_sorted = ::CourtObserverQueries.new(current_court_observer).get_schedule_scores_array(@story)
    redirect_as_fail(court_observer_root_path, "尚未有評鑑紀錄") unless @scores_sorted.present?
  end
end
