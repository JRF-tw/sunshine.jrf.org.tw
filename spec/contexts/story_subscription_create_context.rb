require "rails_helper"

describe StorySubscriptionCreateContext do
  let!(:story) { FactoryGirl.create :story }
  subject { described_class.new(story) }

  context "party subscribe" do
    context "success" do
      let(:party) { FactoryGirl.create :party, :already_confirmed }
      it { expect { subject.perform(party) }.to change { StorySubscription.count }.by(1) }
    end

    context "party not confirmed" do
      let(:party) { FactoryGirl.create :party }
      it { expect { subject.perform(party) }.not_to change { StorySubscription.count } }
    end
  end

end
