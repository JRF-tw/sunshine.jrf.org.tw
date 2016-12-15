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

class ScheduleScore < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :story
  belongs_to :judge
  belongs_to :schedule_rater, polymorphic: true
  has_one    :valid_score, as: :score

  validates :schedule_rater_type, presence: true
  validates :schedule_rater_id, uniqueness: { scope: [:judge_id, :schedule_rater_type] }, presence: true
  validates :judge_id, presence: true
  store_accessor :attitude_scores, :score_1_1, :score_1_2, :score_1_3
  store_accessor :command_scores, :score_2_1, :score_2_2, :score_2_3, :score_2_4, :score_2_5
  store_accessor :data, :court_id, :year, :word_type, :number, :story_type, :start_on, :confirmed_realdate, :judge_name, :note
end
