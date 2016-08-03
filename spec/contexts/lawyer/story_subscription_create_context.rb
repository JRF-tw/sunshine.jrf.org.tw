require "rails_helper"

describe Lawyer::StorySubscriptionCreateContext do
  let!(:story) { create :story }
  subject { described_class.new(story) }

  context "lawyer subscribe" do
    context "success" do
      let(:lawyer) { create :lawyer, :with_confirmed, :with_password }
      it { expect { subject.perform(lawyer) }.to change { StorySubscription.count }.by(1) }
    end

    context "lawyer not registered" do
      let(:lawyer) { create :lawyer }
      it { expect { subject.perform(lawyer) }.not_to change { StorySubscription.count } }
    end
  end

end
