class Story::ActiveAfterVerdictNoticeContext < BaseContext

  def initialize(verdict)
    @verdict = verdict
  end

  def perform
    run_callbacks :perform do
      target_lawyer_id.each do |id|
        LawyerMailer.delay.active_after_verdict_notice(@verdict.id, id)
      end
    end
  end

  def target_lawyer_id
    subscriber_lawyer_ids = @verdict.story.story_subscriptions.where(subscriber_type: 'Lawyer').pluck(:subscriber_id)
    be_notice_lawyer_ids = @verdict.lawyers.where('be_noticed = ? AND confirmed_at IS NOT NULL', true).pluck(:id)
    be_notice_lawyer_ids - subscriber_lawyer_ids
  end
end
