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
  factory :story_subscription_with_party, class: StorySubscription do
    story { create :story }
    subscriber { create :party }

    trait :schedule_tomorrow do
      story { create :story, :with_schedule_date_tomorrow }
    end

    trait :schedule_yesterday do
      story { create :story, :with_schedule_date_yesterday }
    end
  end

end
