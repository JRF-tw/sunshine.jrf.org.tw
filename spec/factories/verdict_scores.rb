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

end
