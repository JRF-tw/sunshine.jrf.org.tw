require 'rails_helper'

describe StorySubscriptionDeleteContext do

  context 'party delete subscription' do
    let!(:story_subscription) { create :story_subscription_with_party }
    let(:story) { Story.last }
    let(:party) { Party.last }
    let(:params) { { token: party.unsubscribe_key } }
    subject { described_class.new(story, party) }

    it { expect { subject.perform(params) }.to change { StorySubscription.count }.by(-1) }
  end

end
