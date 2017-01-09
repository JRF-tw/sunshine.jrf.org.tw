class Story::AfterVerdictNoticeContext < BaseContext

  def initialize(verdict)
    @verdict = verdict
  end

  def perform
    run_callbacks :perform do
      @verdict.story.story_subscriptions.each do |story_subscription|
        subscriber = story_subscription.subscriber
        mailer_constantize(subscriber).delay.after_verdict_notice(@verdict.id, subscriber.id)
      end
    end
  end

  private

  def mailer_constantize(subscriber)
    subscriber_type = subscriber.class.name
    "#{subscriber_type}Mailer".constantize
  end

end
