class Story::ActiveVerdictNoticeContext < BaseContext

  def initialize(verdict)
    @verdict = verdict
  end

  def perform
    run_callbacks :perform do
      target_lawyer_id.each do |id|
        LawyerMailer.delay.active_verdict_notice(@verdict.id, id)
      end
    end
  end

  private

  def target_lawyer_id
    VerdictQueries.new(@verdict).get_active_notice_receiver_id
  end
end
