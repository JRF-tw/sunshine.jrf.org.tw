# == Schema Information
#
# Table name: crawler_histories
#
#  id              :integer          not null, primary key
#  crawler_on      :date
#  courts_count    :integer          default(0), not null
#  branches_count  :integer          default(0), not null
#  judges_count    :integer          default(0), not null
#  verdicts_count  :integer          default(0), not null
#  schedules_count :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :crawler_history do
    crawler_on Time.zone.today

    trait :yesterday do
      crawler_on Time.zone.today - 1.day
    end

    trait :tomorrow do
      crawler_on Time.zone.today + 1.day
    end

    trait :has_verdict do
      verdicts_count { rand(1..50) }
    end
  end
end
