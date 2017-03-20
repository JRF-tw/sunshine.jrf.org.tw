# == Schema Information
#
# Table name: valid_scores
#
#  id               :integer          not null, primary key
#  story_id         :integer
#  judge_id         :integer
#  schedule_id      :integer
#  score_id         :integer
#  score_type       :string
#  score_rater_id   :integer
#  score_rater_type :string
#  attitude_scores  :hstore
#  command_scores   :hstore
#  quality_scores   :hstore
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :valid_score, class: 'ValidScore' do
    score { FactoryGirl.create :schedule_score }
    story { score.story }
    schedule { score.schedule }
    judge { score.judge }
    score_rater { score.schedule_rater }

    trait :with_verdict_score do
      score { FactoryGirl.create :verdict_score }
      schedule nil
      judge { FactoryGirl.create :judge }
      score_rater { score.verdict_rater }
    end
  end

end
