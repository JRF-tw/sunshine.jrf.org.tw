require 'rails_helper'

describe Story::ActiveVerdictNoticeContext do
  let!(:lawyer) { create :lawyer, :with_confirmed }
  let!(:verdict) { create :verdict, :with_file }
  before { create :verdict_relation, verdict: verdict, person: lawyer }
  subject { described_class.new(verdict) }

  describe '#target_lawyer_id' do
    xit 'test in VerdictQueries'
  end

  describe '#perform' do
    it { expect { subject.perform }.to change_sidekiq_jobs_size_of(LawyerMailer, :active_verdict_notice) }
  end
end
