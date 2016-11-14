# == Schema Information
#
# Table name: schedule_scores
#
#  id                  :integer          not null, primary key
#  schedule_id         :integer
#  judge_id            :integer
#  schedule_rater_id   :integer
#  schedule_rater_type :string
#  data                :hstore
#  appeal_judge        :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  story_id            :integer
#  attitude_scores     :hstore
#  command_scores      :hstore
#

FactoryGirl.define do
  factory :schedule_score do
    story { FactoryGirl.create :story }
    schedule { FactoryGirl.create :schedule, story: story }
    judge { FactoryGirl.create :judge }
    schedule_rater { FactoryGirl.create :lawyer }
    trait :by_party do
      schedule_rater { FactoryGirl.create :party }
    end

    trait :without_schedule do
      schedule nil
    end

    trait :with_start_on do
      after(:create) do |schedule_score|
        schedule_score.start_on = Schedule.last.start_on
        schedule_score.save
      end
    end
  end

end
