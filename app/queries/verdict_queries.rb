class VerdictQueries

  def initialize(verdict)
    @verdict = verdict
  end

  def get_active_notice_receiver_id
    subscriber_lawyer_ids = @verdict.story.story_subscriptions.where(subscriber_type: 'Lawyer').pluck(:subscriber_id)
    active_notice_lawyer_ids = @verdict.lawyers.where('active_noticed = ? AND confirmed_at IS NOT NULL', true).pluck(:id)
    active_notice_lawyer_ids - subscriber_lawyer_ids
  end
end
