class Scrap::VerdictScoreConvertContext < BaseContext
  before_perform :check_verdict_score_valid

  def initialize(verdict_score)
    @verdict_score = verdict_score
    @story = @verdict_score.story
    @rater = @verdict_score.verdict_rater
    @verdict = @story.verdicts.find_by_is_judgment(true)
  end

  def perform
    run_callbacks :perform do
      valid_scores = []
      @verdict.judges.each do |judge|
        valid_scores << ValidScore.create!(valid_score_params(judge))
      end
      valid_scores
    end
  end

  private

  def valid_score_params(judge)
    {
      story: @verdict_score.story,
      judge: judge,
      score: @verdict_score,
      score_rater: @rater,
      quality_scores: @verdict_score.quality_scores
    }
  end

  def check_verdict_score_valid
    rater = @rater.class.name.underscore
    return false unless send("#{rater}_valid_score_check")
  end

  def lawyer_valid_score_check
    @verdict.lawyer_names.include?(@rater.name)
  end

  def party_valid_score_check
    @verdict.party_names.include?(@rater.name)
  end

end
