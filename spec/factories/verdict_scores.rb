# == Schema Information
#
# Table name: verdict_scores
#
#  id                 :integer          not null, primary key
#  story_id           :integer
#  verdict_rater_id   :integer
#  verdict_rater_type :string
#  data               :hstore
#  appeal_judge       :boolean
#  status             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  quality_scores     :hstore
#

FactoryGirl.define do
  factory :verdict_score do
    story { FactoryGirl.create :story }
    verdict_rater { FactoryGirl.create :lawyer }

    trait :by_party do
      verdict_rater { FactoryGirl.create :party }
    end
  end

  factory :verdict_score_for_params, class: VerdictScore do
    court_id { FactoryGirl.create(:court).id }
    year '2016'
    word_type '聲'
    number '105'
    story_type '民事'
    score_3_1 '2'
    score_3_2_1 '2'
    score_3_2_2 '2'
    score_3_2_3 '2'
    score_3_2_4 '2'
    score_3_2_5 '2'
    score_3_2_6 '2'
    note 'xxxxx'
    appeal_judge false
  end

  factory :verdict_score_for_update_params, class: VerdictScore do
    score_3_1 '2'
    score_3_2_1 '2'
    score_3_2_2 '2'
    score_3_2_3 '2'
    score_3_2_4 '2'
    score_3_2_5 '2'
    score_3_2_6 '2'
    note 'xxxxx'
    appeal_judge false
  end

  factory :verdict_score_for_update_no_quality_params, class: VerdictScore do
    note 'xxxxx'
    appeal_judge false
  end
end
