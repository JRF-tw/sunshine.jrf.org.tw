require "rails_helper"

describe Lawyer::StorySubscriptionCreateContext do
  let!(:story) { create :story }
  let!(:context) { described_class.new(story) }

  context "lawyer subscribe" do
    context "success" do
      let(:lawyer) { create :lawyer, :with_confirmed, :with_password }
      before { context.perform(lawyer) }
      subject { StorySubscription.last }

      it { expect(subject.subscriber).to eq(lawyer) }
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
end
