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

class ValidScore < ActiveRecord::Base
  validates :story_id, presence: true
  validates :judge_id, presence: true
  validates :score_id, presence: true
  validates :score_type, presence: true
  validates :score_rater_id, presence: true
  validates :score_rater_type, presence: true
  store_accessor :attitude_scores, ScheduleScore.stored_attributes[:attitude_scores]
  store_accessor :command_scores, ScheduleScore.stored_attributes[:command_scores]
  store_accessor :quality_scores, :score_3_1, VerdictScore.stored_attributes[:quality_scores]

  belongs_to :schedule
  belongs_to :story
  belongs_to :judge
  belongs_to :score_rater, polymorphic: true
  belongs_to :score, polymorphic: true
end
