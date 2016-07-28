class CourtObserverQueries
  def initialize(court_observer)
    @court_observer = court_observer
  end

  def get_stories
    story_relations_ids = @court_observer.story_relations.map(&:story_id)
    verdict_scores_story_ids = @court_observer.verdict_scores.map(&:story_id)
    story_ids = (story_relations_ids + verdict_scores_story_ids).uniq
    stories = Story.where(id: story_ids)
    stories
  end

  def get_schedule_score(story)
    scores = @court_observer.schedule_scores.where(story: story)
    scores
  end

  def get_verdict_score(story)
    scores = @court_observer.verdict_scores.where(story: story)
    scores
  end

  def pending_score_schedules(story)
    schedule_ids = story.schedules.map(&:id)
    scored_schedule_ids = @court_observer.schedule_scores.map(&:schedule_id).uniq
    schedules = Schedule.where(id: schedule_ids - scored_schedule_ids)
    schedules
  end

  def pending_score_verdict(story)
    Verdict.find(story.judgment_verdict)
  end
end
