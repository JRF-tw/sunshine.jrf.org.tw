class Parties::SubscribesController < Parties::BaseController

  before_action :find_story, only: [:toggle]

  def toggle
    Party::StorySubscriptionToggleContext.new(@story).perform
  end

  def find_story
    @story = Story.find(params[:id])
  end
end
