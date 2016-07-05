require 'rails_helper'

describe StorySubscriptionDeleteContext do
  
  describe "party delete subscription" do

    let!(:story_subscription) { FactoryGirl.create :story_subscription_with_party }
    let(:story) { Story.last }
    let(:party) { Party.last }
    subject { described_class.new(story) }

    context "success" do
      it { expect{ subject.perform(party) }.to change{ StorySubscription.count }.by(-1) }
    end
  end

end
