class StorySubscriptionDeleteContext < BaseContext
  MD5KEY = 'P2NVel3pHp'.freeze
  before_perform :check_token
  before_perform :find_story_subscription

  def initialize(story)
    @story = story
  end

  def perform(subscriber, params)
    @token = params[:token]
    @subscriber = subscriber
    run_callbacks :perform do
      add_error(:data_delete_fail, @story_subscription.errors.full_messages.join("\n")) unless @story_subscription.destroy
      true
    end
  end

  private

  def check_token
    return add_error(:invalid_token) unless @token == Digest::MD5.hexdigest(@subscriber.email + MD5KEY)
  end

  def find_story_subscription
    @story_subscription = @subscriber.story_subscriptions.find_by_story_id(@story.id)
    return add_error(:story_subscription_not_found) unless @story_subscription
  end

end
