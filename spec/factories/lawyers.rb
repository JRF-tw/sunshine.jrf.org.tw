# == Schema Information
#
# Table name: lawyers
#
#  id         :integer          not null, primary key
#  name       :string
#  current    :string
#  avatar     :string
#  gender     :string
#  birth_year :integer
#  memo       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :lawyer do
    name "lawyer"
    sequence(:email) { |n| "bystander-#{n}@test.com"}

    trait :with_avatar do
      avatar File.open "#{Rails.root}/spec/fixtures/person_avatar/people-1.jpg"
    end

    trait :with_password_and_confirmed do
      password "123123123"
      confirmed_at Time.now
    end

    trait :with_gender do
      gender "男"
    end

    trait :with_verdict do
      after(:create) do |lawyer|
        FactoryGirl.create :lawyer_verdict, lawyer: lawyer, verdict: FactoryGirl.create(:verdict)
      end
    end
  end

  factory :empty_name_for_lawyer, class: Lawyer do
    name ""
  end

end
