class PartyQueries
  def initialize(party)
    @party = party
  end

  def get_stories
    story_relations_ids = @party.story_relations.map(&:story_id)
    verdict_scores_story_ids = @party.verdict_scores.map(&:story_id)
    schedule_scores_story_ids = @party.schedule_scores.map(&:story_id)
    story_ids = (story_relations_ids + verdict_scores_story_ids + schedule_scores_story_ids).uniq
    stories = Story.where(id: story_ids)
    stories
  end

  def get_relate_stories
    stories = []
    @party.story_relations.each { |sr| stories << sr.story }
    stories
  end

  def get_schedule_score(story)
    scores = @party.schedule_scores.where(story: story)
    scores
  end

  def get_verdict_score(story)
    score = @party.verdict_scores.find_by_story_id(story.id)
    score
  end

  def pending_score_schedules(story)
    schedule_ids = story.schedules.map(&:id)
    scored_schedule_ids = @party.schedule_scores.map(&:schedule_id).uniq
    schedules = Schedule.where(id: schedule_ids - scored_schedule_ids)
    schedules
  end

  def pending_score_verdict(story)
    story.judgment_verdict ? Verdict.find(story.judgment_verdict.id) : nil
  end

  def get_scores_array(story, sort_by: "date")
    scores_array = []
    scores_array += schedule_scores_data_array(story) if schedule_scores_data_array(story)
    scores_array += verdict_score_data_array(story) if verdict_score_data_array(story)
    scores_array.sort_by { |k| k[sort_by] }
  end

  private

  def schedule_scores_data_array(story)
    schedule_scores_array = []
    court_code = story.court.code
    @party.schedule_scores.where(story: story).each do |schedule_score|
      ss_hash = schedule_score.as_json
      ss_hash["date"] = schedule_score.schedule.date
      ss_hash["court_code"] = court_code
      ss_hash["schedule_score"] = true
      schedule_scores_array << ss_hash
    end
    schedule_scores_array
  end

  def verdict_score_data_array(story)
    if verdict_score = @party.verdict_scores.find_by_story_id(story.id)
      date = verdict_score.story.adjudge_date
      court_code = story.court.code
      vs_hash = verdict_score.as_json
      vs_hash["date"] = date
      vs_hash["court_code"] = court_code
      vs_hash["verdict_score"] = true
      [] << vs_hash
    end
  end

end
