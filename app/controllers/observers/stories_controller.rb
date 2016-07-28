class Observers::StoriesController < Observers::BaseController
  layout "observer"
  before_action :find_story, only: [:show]
  before_action :has_score?, only: [:show]

  def index
    @stories = ::CourtObserverQueries.new(current_court_observer).get_stories
  end

  def show
    @pending_score_verdict = ::CourtObserverQueries.new(current_court_observer).pending_score_verdict(@story)
    @pending_score_schedules = ::CourtObserverQueries.new(current_court_observer).pending_score_schedules(@story)
  end

  private

  def find_story
    # TODO: security issue
    @story = Story.find(params[:id])
    redirect_as_fail(observer_stories_path, "找不到該案件") unless @story
  end

  def has_score?
    @verdict_score = ::CourtObserverQueries.new(current_court_observer).get_verdict_score(@story)
    @schedule_score = ::CourtObserverQueries.new(current_court_observer).get_schedule_score(@story)
    redirect_as_fail(observer_stories_path, "尚未有評鑑紀錄") unless @verdict_score.present? || @schedule_score.present?
  end
end
