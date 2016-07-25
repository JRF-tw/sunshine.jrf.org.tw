# == Schema Information
#
# Table name: schedules
#
#  id              :integer          not null, primary key
#  story_id        :integer
#  court_id        :integer
#  branch_name     :string
#  date            :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  branch_judge_id :integer
#

FactoryGirl.define do
  factory :schedule do
    branch_name "股別名稱"
    date { Date.current }
    court { create :court }
    story { create :story }

    trait :with_branch_judge do
      branch_judge { create :judge }
    end

    trait :date_is_tomorrow do
      date { Date.tomorrow }
    end

    trait :date_is_yesterday do
      date { Date.yesterday }
    end
  end

end
