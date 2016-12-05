class StoryCalculateScheduleScoresContext < BaseContext

  def initialize(story)
    @story = story
    @schedule_scores = @story.schedule_scores
  end

  def perform
    run_callbacks :perform do
      @schedule_scores.each do |ss|
        ScheduleScoreConvertContext.new(ss).perform
      end
    end
  end

end
