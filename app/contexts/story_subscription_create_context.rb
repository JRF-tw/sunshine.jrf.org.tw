class StorySubscriptionCreateContext < BaseContext

  before_perform :check_party_confirm
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
        add_error(:data_create_fail, @story_subscription.errors.full_messages.join("\n"))
      end
    end
  end

  def check_party_confirm
    add_error(:data_create_fail, "訂閱案件前請先完成驗證") if @subscriber.class == Party && !@subscriber.confirmed?
  end

  def build_data
    @story_subscription = @story.story_subscriptions.new(subscriber: @subscriber, story: @story)
  end


end
