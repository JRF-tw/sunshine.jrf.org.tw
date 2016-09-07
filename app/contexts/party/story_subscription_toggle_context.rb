class Party::StorySubscriptionToggleContext < BaseContext

  before_perform :check_confirmed
  before_perform :build_data

  def initialize(story)
    @story = story
  end

  def perform(party)
    @party = party
    run_callbacks :perform do
      if @story_subscription.save
        @story_subscription
      else
        add_error(:story_subscriber_failed, @story_subscription.errors.full_messages.join("\n"))
      end
    end
  end

  def check_confirmed
    return add_error(:story_subscriber_valid_failed, "訂閱案件前請先完成驗證") unless @party.confirmed?
  end

  def build_data
    @story_subscription = @story.story_subscriptions.new(subscriber: @party, story: @story)
  end

end
