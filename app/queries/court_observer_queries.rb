class CourtObserverQueries
  def initialize(court_observer)
    @court_observer = court_observer
  end

  def get_stories
    schedule_scores_story_ids = @court_observer.schedule_scores.map(&:story_id)
    stories = Story.where(id: schedule_scores_story_ids.uniq)
    stories
  end

  def get_schedule_scores_array(story, sort_by: 'date')
    schedule_scores_array = []
    court_code = story.court.code
    @court_observer.schedule_scores.where(story: story).each do |schedule_score|
      ss_hash = schedule_score.as_json
      ss_hash['date'] = schedule_score.start_on
      ss_hash['court_code'] = court_code
      ss_hash['schedule_score'] = true
      schedule_scores_array << ss_hash
    end
    schedule_scores_array.sort_by { |k| k[sort_by] }
  end

  def pending_score_schedules(story)
    schedule_ids = story.schedules.map(&:id)
    scored_schedule_ids = @court_observer.schedule_scores.map(&:schedule_id).uniq
    schedules = Schedule.where(id: schedule_ids - scored_schedule_ids)
    schedules
  end
end
