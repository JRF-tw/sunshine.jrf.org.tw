# == Schema Information
#
# Table name: verdict_scores
#
#  id                 :integer          not null, primary key
#  verdict_id         :integer
#  judge_id           :integer
#  verdict_rater_id   :integer
#  verdict_rater_type :string
#  quality_score      :integer
#  rating_score       :integer
#  data               :hstore
#  appeal_judge       :boolean
#  status             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :verdict_score do
    story { FactoryGirl.create :story }
    judge { FactoryGirl.create :judge }
    verdict_rater { FactoryGirl.create :lawyer }
  end

end
