class Lawyer::StorySubscriptionToggleContext < BaseContext
  before_perform :check_confirmed
  before_perform :check_set_password
  before_perform :find_story_subscription
  before_perform :build_data

  def initialize(story)
    @story = story
  end

  def perform(lawyer)
    @lawyer = lawyer
    run_callbacks :perform do
      if @story_subscription.new_record? ? @story_subscription.save : @story_subscription.destroy
        @story_subscription
      else
        add_error(:story_subscriber_failed, @story_subscription.errors.full_messages.join("\n"))
      end
    end
  end

  private

  def check_confirmed
    return add_error(:subscriber_not_sign_up) unless @lawyer.confirmed?
  end

  def check_set_password
    return add_error(:subscriber_without_password) unless @lawyer.encrypted_password.present?
  end

  def find_story_subscription
    @story_subscription = @lawyer.story_subscriptions.find_by(story_id: @story.id)
  end

  def build_data
    @story_subscription = @story.story_subscriptions.new(subscriber: @lawyer) unless @story_subscription
  end

end
