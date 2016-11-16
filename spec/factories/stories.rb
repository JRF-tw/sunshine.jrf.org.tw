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
#  is_adjudge       :boolean          default(FALSE)
#  adjudge_date     :date
#  pronounce_date   :date
#  is_pronounce     :boolean          default(FALSE)
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
      pronounce_date Time.zone.today
      is_pronounce true
    end

    trait :adjudged do
      adjudge_date Time.zone.today
      is_adjudge true
    end

    trait :with_adjugde_verdict do
      after(:create) do |story|
        create :verdict, is_judgment: true, story: story
      end
    end

    trait :adjudged_yesterday do
      adjudge_date Time.zone.yesterday
      is_adjudge true
    end

  end

end
