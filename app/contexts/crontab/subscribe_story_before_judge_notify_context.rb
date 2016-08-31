class Crontab::SubscribeStoryBeforeJudgeNotifyContext < BaseContext

  before_perform :find_before_judge_story

  def initialize(date)
    @date = date
  end

  def perform
    run_callbacks :perform do
      @open_court_story.each do |story|
        StoryBeforeJudgeNoticeContext.new(story).perform
      end

    end
  end

  private

  def find_before_judge_story
    @open_court_story = []
    Schedule.where(start_on: @date.tomorrow).each { |schedule| @open_court_story << schedule.story }
  end

end
