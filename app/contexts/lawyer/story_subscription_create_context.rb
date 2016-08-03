class Lawyer::StorySubscriptionCreateContext < BaseContext

  before_perform :check_confirmed
  before_perform :check_set_password
  before_perform :build_data

  def initialize(story)
    @story = story
  end

  def perform(lawyer)
    @lawyer = lawyer
    run_callbacks :perform do
      if @story_subscription.save
        @story_subscription
      else
        add_error(:story_subscriber_failed, @story_subscription.errors.full_messages.join("\n"))
      end
    end
  end

  def check_confirmed
    return add_error(:story_subscriber_valid_failed, "訂閱案件前請先註冊") unless @lawyer.confirmed?
  end

  def check_set_password
    return add_error(:story_subscriber_valid_failed, "訂閱案件前請先設定密碼") unless @lawyer.encrypted_password.present?
  end

  def build_data
    @story_subscription = @story.story_subscriptions.new(subscriber: @lawyer, story: @story)
  end

end
