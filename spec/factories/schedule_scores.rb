# == Schema Information
#
# Table name: schedule_scores
#
#  id                  :integer          not null, primary key
#  schedule_id         :integer
#  judge_id            :integer
#  schedule_rater_id   :integer
#  schedule_rater_type :string
#  rating_score        :integer
#  command_score       :integer
#  attitude_score      :integer
#  data                :hstore
#  appeal_judge        :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  story_id            :integer
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
  end

end
