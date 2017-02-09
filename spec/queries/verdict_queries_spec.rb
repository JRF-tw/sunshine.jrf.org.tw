require 'rails_helper'

RSpec.describe VerdictQueries do
  let!(:verdict) { create :verdict, :with_file }
  let!(:query) { described_class.new(verdict) }

  describe '#get_active_notice_receiver_id' do
    let!(:lawyer) { create :lawyer, :with_confirmed }
    before { create :verdict_relation, verdict: verdict, person: lawyer }

    context 'confirmed && active_notice && no subscription' do
      it { expect(query.get_active_notice_receiver_id).to include(lawyer.id) }
    end

    context 'not confirmed' do
      before { lawyer.update_attributes(confirmed_at: nil) }
      it { expect(query.get_active_notice_receiver_id).not_to include(lawyer.id) }
    end

    context 'confirmed && active_notice && subscription' do
      let!(:story_subscription) { create :story_subscription, story: verdict.story, subscriber: lawyer }
      it { expect(query.get_active_notice_receiver_id).not_to include(lawyer.id) }
    end
  end
end
