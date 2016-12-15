class Story::CalculateVerdictScoresContext < BaseContext

  def initialize(story)
    @story = story
    @verdict_scores = @story.verdict_scores
  end

  def perform
    run_callbacks :perform do
      @verdict_scores.each do |vs|
        VerdictScoreConvertContext.new(vs).perform
      end
    end
  end
end
