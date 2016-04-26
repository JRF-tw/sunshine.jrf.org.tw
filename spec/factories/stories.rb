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
#  defendant_names  :text
#  lawyer_names     :text
#  judges_names     :text
#  prosecutor_names :text
#

FactoryGirl.define do
  factory :story do
    story_type "民事"
    year { rand(70..105) }
    word_type "聲"
    number { rand(100..999) }
    court { FactoryGirl.create :court }

    trait :with_schedule do
      after(:create) do |story|
        FactoryGirl.create :schedule, story: story
      end
    end 
  end

end
