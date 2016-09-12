# == Schema Information
#
# Table name: schedule_scores
#
#  id                  :integer          not null, primary key
#  schedule_id         :integer
#  judge_id            :integer
#  schedule_rater_id   :integer
#  schedule_rater_type :string
#  rating_score        :float
#  command_score       :float
#  attitude_score      :float
#  data                :hstore
#  appeal_judge        :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  story_id            :integer
#

class ScheduleScore < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :story
  belongs_to :judge
  belongs_to :schedule_rater, polymorphic: true

  validates :schedule_rater_type, presence: true
  validates :schedule_rater_id, uniqueness: { scope: :judge_id }, presence: true
  validates :judge_id, presence: true
  store_accessor :data, :court_id, :year, :word_type, :number, :start_on, :confirmed_realdate, :judge_name, :note
end
