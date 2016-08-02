class StorySubscriptionCreateContext < BaseContext

  before_perform :check_party_confirmed, if: :is_party?
  before_perform :check_lawyer_registered, if: :is_lawyer?
  before_perform :build_data

  def initialize(story)
    @story = story
  end

  def perform(subscriber)
    @subscriber = subscriber
    run_callbacks :perform do
      if @story_subscription.save
        @story_subscription
      else
        add_error(:story_subscriber_failed, @story_subscription.errors.full_messages.join("\n"))
      end
    end
  end

  def is_party?
    @subscriber.class == Party
  end

  def is_lawyer?
    @subscriber.class == Lawyer
  end

  def check_party_confirmed
    add_error(:story_subscriber_valid_failed, "訂閱案件前請先完成驗證") unless @subscriber.confirmed?
  end

  def check_lawyer_registered
    add_error(:story_subscriber_valid_failed, "訂閱案件前請先註冊與設定密碼") unless @subscriber.confirmed? && @subscriber.password.present?
  end

  def build_data
    @story_subscription = @story.story_subscriptions.new(subscriber: @subscriber, story: @story)
  end

end
