# == Schema Information
#
# Table name: story_subscriptions
#
#  id              :integer          not null, primary key
#  story_id        :integer
#  subscriber_id   :integer
#  subscriber_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require "rails_helper"
RSpec.describe StorySubscription, type: :model do
  let(:story_subscription) { create :story_subscription_with_party }

  context "FactoryGirl" do
    it { expect(story_subscription).not_to be_new_record }
  end
end
