class VerdictScoreConvertContext < BaseContext
  before_perform :check_verdict_score_valid

  def initialize(verdict_score)
    @verdict_score = verdict_score
    @story = @verdict_score.story
    @rater = @verdict_score.verdict_rater
    @verdict = @story.verdict
    @quality_scores = @verdict_score.quality_scores
  end

  def perform
    run_callbacks :perform do
      valid_scores = []
      @verdict.judges.each do |judge|
        valid_score = build_valid_score(judge)
        valid_scores << valid_score.save || valid_score.errors.full_messages
      end
      valid_scores
    end
  end

  private

  def build_valid_score(judge)
    data = {
      story: @story,
      judge: judge,
      score: @verdict_score,
      score_rater: @rater,
      quality_scores: @quality_scores
    }
    ValidScore.new(data)
  end

  def check_verdict_score_valid
    rater = @rater.class.name.underscore
    return false unless send("#{rater}_valid_score_check")
  end

  def lawyer_valid_score_check
    @verdict.lawyers.include?(@rater)
  end

  def party_valid_score_check
    @verdict.parties.include?(@rater)
  end

end
