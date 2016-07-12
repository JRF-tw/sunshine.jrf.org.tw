# == Schema Information
#
# Table name: stories
#
#  id               :integer          not null, primary key
#  court_id         :integer
#  main_judge_id    :integer
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
    story_type "民事"
    year { rand(70..105) }
    word_type "聲"
    number { rand(100..999) }
    court { FactoryGirl.create :court }
    main_judge { FactoryGirl.create :judge }

    trait :with_schedule_date_tomorrow do
      after(:create) do |story|
        FactoryGirl.create :schedule, :date_is_tomorrow, story: story
      end
    end

    trait :with_schedule_date_yesterday do
      after(:create) do |story|
        FactoryGirl.create :schedule, :date_is_yesterday, story: story
      end
    end

  end

end
