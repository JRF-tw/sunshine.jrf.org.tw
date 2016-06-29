require 'rails_helper'

RSpec.describe StorySubscription, type: :model do
  describe "normalize" do
    let!(:story_subscription) { FactoryGirl.create :story_subscription_with_party }
    it { expect(story_subscription).to be_present }
    it { expect(story_subscription.subscriber).to eq(Party.last) }
  end
end
