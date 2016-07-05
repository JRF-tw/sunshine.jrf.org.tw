require "rails_helper"
RSpec.describe StorySubscription, type: :model do
  let(:story_subscription) { FactoryGirl.create :story_subscription_with_party }

  context "FactoryGirl" do
    it { expect(story_subscription).not_to be_new_record }
  end
end
