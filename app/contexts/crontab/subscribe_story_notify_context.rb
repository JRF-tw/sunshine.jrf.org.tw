class  Crontab::SubscribeStoryNotifyContext < BaseContext

  before_perform :find_open_court_story
  before_perform :find_close_court_story

  def initialize(date)
    @date = date
  end

  def perform
    run_callbacks :perform do
      @open_court_story.each do |story|
        OpenCourtNotifyContext.new(story).perform
      end

      @close_court_story.each do |story|
        CloseCourtNotifyContext.new(story).perform
      end
    end
  end

  private

  def find_open_court_story
    @open_court_story = []
    Schedule.where(date: @date.tomorrow).each { |schedule| @open_court_story  << schedule.story }
  end

  def find_close_court_story
    @close_court_story = []
    Schedule.where(date: @date.yesterday).each { |schedule| @close_court_story  << schedule.story }
  end

end

