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

FactoryGirl.define do
  factory :story_subscription do
    story { FactoryGirl.create :story }
    subscriber { FactoryGirl.create :party }
  end

  factory :story_subscription_with_party, class: StorySubscription do
    story { FactoryGirl.create :story, :with_schedule }
    subscriber { FactoryGirl.create :party }
  end

end
