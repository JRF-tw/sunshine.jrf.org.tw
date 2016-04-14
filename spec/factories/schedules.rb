# == Schema Information
#
# Table name: schedules
#
#  id          :integer          not null, primary key
#  story_id    :integer
#  court_id    :integer
#  branch_name :string
#  date        :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :schedule do
    branch_name "股別名稱"
    date { Date.current }

    trait :with_court do
      after(:create) do |schedule|
        court = FactoryGirl.create :court
        schedule.update_attribute :court_id, court.id
      end  
    end
  end  

end
