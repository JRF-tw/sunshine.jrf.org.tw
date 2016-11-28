# == Schema Information
#
# Table name: valid_scroes
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
#

FactoryGirl.define do
  factory :valid_score, class: 'ValidScore' do

  end

end
