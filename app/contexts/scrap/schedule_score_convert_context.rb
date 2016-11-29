class Scrap::ScheduleScoreConvertContext < BaseContext
  before_perform :check_Schedule_score_valid

  def initialize(schedule_score, schedule: nil)
    @schedule_score = schedule_score
    @schedule = schedule
    @story = @schedule_score.story
    @rater = @schedule_score.schedule_rater
  end

  def perform
    run_callbacks :perform do
      valid_score = ValidScore.new(valid_score_params)
      return false unless valid_score.save!
      valid_score
    end
  end

  private

  def valid_score_params
    { 
      score: @schedule_score, 
      story: @schedule_score.story, 
      judge: @schedule_score.judge, 
      score_rater: @rater, 
      schedule: @schedule, 
      attitude_scores: @schedule_score.attitude_scores, 
      command_scores: @schedule_score.command_scores 
    }
  end

  def check_Schedule_score_valid
    rater =  @rater.class.name.underscore
    return false unless self.send("#{rater}_valid_score_check")
  end

  def court_observer_valid_score_check
    judge_exist?
  end

  def lawyer_valid_score_check
    judge_exist? && lawyer_exist?
  end

  def party_valid_score_check
    judge_exist? && party_exist?
  end

  def judge_exist?
    @story.verdicts.find_by_is_judgment(true).judges_names.include?(@schedule_score.judge.name)
  end

  def lawyer_exist?
    @story.verdicts.find_by_is_judgment(true).lawyer_names.include?(@rater.name)
  end

  def party_exist?
    @story.verdicts.find_by_is_judgment(true).party_names.include?(@rater.name)
  end

end
