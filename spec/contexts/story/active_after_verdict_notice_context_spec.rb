require 'rails_helper'

describe Story::ActiveAfterVerdictNoticeContext do
  let!(:lawyer) { create :lawyer, :with_confirmed }
  let!(:verdict) { create :verdict, :with_file }
  let!(:verdict_relation) { create :verdict_relation, verdict: verdict, person: lawyer }
  subject { described_class.new(verdict) }

  describe '#target_lawyer_id' do
    context 'confirmed && be_noticed && no subscription' do
      it { expect(subject.target_lawyer_id).to include(lawyer.id) }
    end

    context 'not confirmed' do
      before { lawyer.update_attributes(confirmed_at: nil) }
      it { expect(subject.target_lawyer_id).not_to include(lawyer.id) }
    end

    context 'confirmed && be_noticed && subscription' do
      let!(:story_subscription) { create :story_subscription, story: verdict.story, subscriber: lawyer }
      it { expect(subject.target_lawyer_id).not_to include(lawyer.id) }
    end
  end

  describe '#perform' do
    it { expect { subject.perform }.to change_sidekiq_jobs_size_of(Sidekiq::Extensions::DelayedMailer) }
  end
end
