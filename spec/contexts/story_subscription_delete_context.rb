require "rails_helper"

describe StorySubscriptionDeleteContext do

  context "party delete subscription" do
    let!(:story_subscription) { create :story_subscription_with_party }
    let(:story) { Story.last }
    let(:party) { Party.last }
    subject { described_class.new(story) }

    it { expect { subject.perform(party) }.to change { StorySubscription.count }.by(-1) }
  end

end
