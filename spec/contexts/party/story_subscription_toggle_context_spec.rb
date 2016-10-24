require 'rails_helper'

describe Party::StorySubscriptionToggleContext do
  let!(:story) { create :story }
  let(:party) { create :party, :already_confirmed }
  let!(:context) { described_class.new(story) }

  context 'party subscribe' do
    subject { context.perform(party) }
    it { expect { subject }.to change { StorySubscription.count }.by(1) }
  end

  context 'party unsubscribe' do
    let!(:story_subscribe) { create :story_subscription, story: story, subscriber: party }
    subject { context.perform(party) }

    it { expect { subject }.to change { StorySubscription.count }.from(1).to(0) }
  end

  context 'party not confirmed' do
    let(:party) { create :party }
    subject { context.perform(party) }
    it { expect { subject }.not_to change { StorySubscription.count } }
  end

end
