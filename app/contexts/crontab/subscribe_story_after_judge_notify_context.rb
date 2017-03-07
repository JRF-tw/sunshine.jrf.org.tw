class Crontab::SubscribeStoryAfterJudgeNotifyContext < BaseContext
  before_perform :find_after_judge_story

  def initialize(date)
    @date = date
  end

  def perform
    run_callbacks :perform do
      @close_court_story.each do |story|
        Story::AfterJudgeNoticeContext.new(story).perform
      end
    end
  end

  private

  def find_after_judge_story
    @close_court_story = []
    Schedule.where(start_on: @date).each { |schedule| @close_court_story << schedule.story }
  end

end
