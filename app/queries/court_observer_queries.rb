class CourtObserverQueries
  def initialize(court_observer)
    @court_observer = court_observer
  end

  def get_stories
    schedule_scores_story_ids = @court_observer.schedule_scores.map(&:story_id)
    stories = Story.where(id: schedule_scores_story_ids.uniq)
    stories
  end

  def get_schedule_score(story)
    scores = @court_observer.schedule_scores.where(story: story)
    scores.includes(:schedule).order("schedules.date")
  end

  def pending_score_schedules(story)
    schedule_ids = story.schedules.map(&:id)
    scored_schedule_ids = @court_observer.schedule_scores.map(&:schedule_id).uniq
    schedules = Schedule.where(id: schedule_ids - scored_schedule_ids)
    schedules
  end
end
