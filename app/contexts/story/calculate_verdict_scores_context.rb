class Story::CalculateVerdictScoresContext < BaseContext
  after_perform :update_story_status

  class << self
    def perform(story)
      new(story).perform
    end
  end

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

  private

  def update_story_status
    @story.update_attributes(is_calculated: true)
  end
end
