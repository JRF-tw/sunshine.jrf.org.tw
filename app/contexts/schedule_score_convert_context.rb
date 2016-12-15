class ScheduleScoreConvertContext < BaseContext
  before_perform :check_schedule_score_valid
  before_perform :build_valid_score

  def initialize(schedule_score)
    @schedule_score = schedule_score
    @story = @schedule_score.story
    @verdict = @story.judgment_verdict
    @rater = @schedule_score.schedule_rater
    @judge = @schedule_score.judge
    @schedule = @schedule_score.schedule
    @attitude_scores = @schedule_score.attitude_scores
    @command_scores = @schedule_score.command_scores
  end

  def perform
    run_callbacks :perform do
      return false unless @valid_score.save
      @valid_score
    end
  end

  private

  def build_valid_score
    data = {
      story: @story,
      judge: @judge,
      schedule: @schedule,
      score: @schedule_score,
      score_rater: @rater,
      attitude_scores: @attitude_scores,
      command_scores: @command_scores
    }
    @valid_score = ValidScore.new(data)
  end

  def check_schedule_score_valid
    rater = @rater.class.name.underscore
    return false unless send("#{rater}_valid_score_check")
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
    @verdict.judges.include?(@schedule_score.judge)
  end

  def lawyer_exist?
    @verdict.lawyers.include?(@rater)
  end

  def party_exist?
    @verdict.parties.include?(@rater)
  end

end
