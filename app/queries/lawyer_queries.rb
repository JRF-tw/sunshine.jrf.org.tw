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
    scores = @lawyer.verdict_scores.find_by_story_id(story.id)
    scores
  end

  def already_subscribed_story?(story)
    @lawyer.story_subscriptions.find_by(story_id: story.id).present?
  end

  def pending_score_schedules(story)
    schedule_ids = story.schedules.map(&:id)
    scored_schedule_ids = @lawyer.schedule_scores.map(&:schedule_id).uniq
    schedules = Schedule.where(id: schedule_ids - scored_schedule_ids)
    schedules
  end

  def pending_score_verdict(story)
    !get_verdict_score(story) && story.verdict ? Verdict.find(story.verdict.id) : nil
  end

  def get_scores_array(story, sort_by: 'date')
    scores_array = []
    scores_array += schedule_scores_data_array(story) if schedule_scores_data_array(story)
    scores_array += verdict_score_data_array(story) if verdict_score_data_array(story)
    scores_array.sort_by { |k| k[sort_by] }
  end

  private

  def schedule_scores_data_array(story)
    schedule_scores_array = []
    court_code = story.court.code
    @lawyer.schedule_scores.where(story: story).each do |schedule_score|
      ss_hash = schedule_score.as_json
      ss_hash['date'] = schedule_score.start_on
      ss_hash['court_code'] = court_code
      ss_hash['schedule_score'] = true
      schedule_scores_array << ss_hash
    end
    schedule_scores_array
  end

  def verdict_score_data_array(story)
    if verdict_score = @lawyer.verdict_scores.find_by_story_id(story.id)
      vs_hash = verdict_score.as_json
      vs_hash['date'] = verdict_score.story.adjudged_on.to_s
      vs_hash['court_code'] = story.court.code
      vs_hash['verdict_score'] = true
      [] << vs_hash
    end
  end
end
