class StorySubscriptionDeleteContext < BaseContext

  before_perform :find_story_subscription

  def initialize(story)
    @story = story
  end

  def perform(subscriber)
    @subscriber = subscriber
    run_callbacks :perform do 
      add_error(:data_create_fail, @story_subscription.errors.full_messages.join("\n")) unless @story_subscription.destroy
      true
    end
  end

  def find_story_subscription
    @story_subscription = @subscriber.story_subscriptions.find_by_story_id(@story.id)
  end


end
