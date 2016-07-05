class StoryBeforeJudgeNoticeContext < BaseContext

  def initialize(story)
    @story = story
  end

  def perform
    run_callbacks :perform do
      @story.story_subscriptions.each do |story_subscription|
        subscriber = story_subscription.subscriber
        subscriber_type = subscriber.class.name
        klass = Kernel.const_get("#{subscriber_type}Mailer")
        klass.delay.send("story_after_judge_notice(#{@story.id}, #{subscriber.id})")
      end
    end
  end

end
