# == Schema Information
#
# Table name: stories
#
#  id               :integer          not null, primary key
#  court_id         :integer
#  story_type       :string
#  year             :integer
#  word_type        :string
#  number           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  party_names      :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#  is_adjudged      :boolean          default(FALSE)
#  adjudged_on      :date
#  pronounced_on    :date
#  is_pronounced    :boolean          default(FALSE)
#  is_calculated    :boolean          default(FALSE)
#  reason           :string
#  schedules_count  :integer          default(0)
#

FactoryGirl.define do
  factory :story do
    story_type '民事'
    year { rand(70..105) }
    word_type '聲'
    number { rand(100..999) }
    court { create :court }

    trait :with_schedule_date_tomorrow do
      after(:create) do |story|
        create :schedule, :date_is_tomorrow, story: story
      end
    end

    trait :with_schedule_date_today do
      after(:create) do |story|
        FactoryGirl.create :schedule, story: story
      end
    end

    trait :with_schedule_date_yesterday do
      after(:create) do |story|
        create :schedule, :date_is_yesterday, story: story
      end
    end

    trait :pronounced do
      pronounced_on Time.zone.today
      is_pronounced true
    end

    trait :adjudged do
      adjudged_on Time.zone.today
      is_adjudged true
    end

    trait :with_verdict do
      after(:create) do |story|
        create :verdict, :with_file, story: story
      end
    end

    trait :adjudged_yesterday do
      adjudged_on Time.zone.yesterday
      is_adjudged true
    end

  end

end
