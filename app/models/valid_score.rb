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

class ValidScore < ActiveRecord::Base
  validates :story_id, presence: true
  validates :score_id, presence: true
  validates :score_type, presence: true
  validates :score_rater_id, presence: true
  validates :score_rater_type, presence: true
  store_accessor :attitude_scores, :score_1_1, :score_1_2, :score_1_3
  store_accessor :command_scores, :score_2_1, :score_2_2, :score_2_3, :score_2_4, :score_2_5
  store_accessor :quality_scores, :score_3_1, :score_3_2_1, :score_3_2_2, :score_3_2_3, :score_3_2_4, :score_3_2_5, :score_3_2_6

  belongs_to :schedule
  belongs_to :story
  belongs_to :judge
  belongs_to :score_rater, polymorphic: true
  belongs_to :score, polymorphic: true
end
