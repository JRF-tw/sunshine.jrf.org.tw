class LawyerQueries
  def initialize(lawyer)
    @lawyer = lawyer
  end

  def get_stories
    story_relations_ids = @lawyer.story_relations.map(&:story_id)
    verdict_scores_story_ids = @lawyer.verdict_scores.map(&:story_id)
    schedule_scores_story_ids = @lawyer.schedule_scores.map(&:story_id)
    story_ids = (story_relations_ids + verdict_scores_story_ids + schedule_scores_story_ids).uniq
    stories = Story.where(id: story_ids)
    stories
  end

  def get_schedule_score(story)
    scores = @lawyer.schedule_scores.where(story: story)
    scores
  end

  def get_verdict_score(story)
    scores = @lawyer.verdict_scores.where(story: story)
    scores
  end

  def pending_score_schedules(story)
    schedule_ids = story.schedules.map(&:id)
    scored_schedule_ids = @lawyer.schedule_scores.map(&:schedule_id).uniq
    schedules = Schedule.where(id: schedule_ids - scored_schedule_ids)
    schedules
  end

  def pending_score_verdict(story)
    story.judgment_verdict ? Verdict.find(story.judgment_verdict.id) : nil
  end
end
