class CloseCourtNotifyContext < BaseContext

  def initialize(story)
    @story = story
  end

  def perform
    run_callbacks :perform do
      @story.story_subscriptions.each do |story_subscription|
        subscriber = story_subscription.subscriber
        subscriber_type = subscriber.class.name
        eval("#{subscriber_type}Mailer.delay.close_court_notice(#{@story.id},#{subscriber.id})")
      end
    end
  end


end
