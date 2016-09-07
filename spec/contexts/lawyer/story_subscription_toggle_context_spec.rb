require "rails_helper"

describe Lawyer::StorySubscriptionToggleContext do
  let!(:story) { create :story }
  let(:lawyer) { create :lawyer, :with_confirmed, :with_password }
  let!(:context) { described_class.new(story) }

  context "lawyer subscribe" do
    before { context.perform(lawyer) }
    subject { StorySubscription.last }

    it { expect(subject.subscriber).to eq(lawyer) }
  end

  context "lawyer unsubscribe" do
    let!(:story_subscribe) { create :story_subscription, story: story, subscriber: lawyer }
    subject { context.perform(lawyer) }

    it { expect{ subject }.to change { StorySubscription.count }.from(1).to(0) }
  end

  context "lawyer not registered" do
    let(:lawyer) { create :lawyer }
    it { expect { context.perform(lawyer) }.not_to change { StorySubscription.count } }
  end

  context "lawyer not set password" do
    let(:lawyer) { create :lawyer, :with_confirmed }
    it { expect { context.perform(lawyer) }.not_to change { StorySubscription.count } }
  end
end
