# == Schema Information
#
# Table name: courts
#
#  id         :integer          not null, primary key
#  full_name  :string
#  name       :string
#  weight     :integer
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean          default(TRUE)
#  code       :string
#  scrap_name :string
#

FactoryGirl.define do
  factory :court do
    sequence(:full_name) { |n| "測試法院-#{n}" }
    sequence(:name) { |n| "測試地院-#{n}" }
    sequence(:code) { ('A'..'Z').to_a.sample(3).join }
    sequence(:scrap_name) { |n| "faker-court-#{n}" }
    is_hidden false

    trait :with_weight do
      after(:create, &:insert_at)
    end

    trait :with_judge do
      after(:create) do |court|
        create :judge, court: court
      end
    end
  end

  factory :court_for_params, class: Court do
    full_name '‎臺灣'
    name '‎新北'
  end

end
