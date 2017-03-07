class Crontab::ConvertExpiredVerdictScoreContext < BaseContext
  before_perform :find_expired_story

  def initialize(date)
    @date = date
  end

  def perform
    run_callbacks :perform do
      @stories.each do |story|
        Story::CalculateVerdictScoresContext.delay.perform(story)
      end
    end
  end

  private

  def find_expired_story
    @stories = Story.not_caculate.where('pronounce_date < ?', @date - 3.months)
  end

end
