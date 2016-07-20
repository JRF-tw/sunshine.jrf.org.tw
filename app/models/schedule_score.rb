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
#

class ScheduleScore < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :story
  belongs_to :judge
  belongs_to :schedule_rater, polymorphic: true

  validates :schedule_rater_type, presence: true
  validates :schedule_rater_id, presence: true
  validates :schedule_id, uniqueness: { scope: :schedule_rater_id }, allow_nil: true
  validates :judge_id, presence: true
  store_accessor :data, :court_id, :year, :word_type, :number, :date, :confirmed_realdate, :judge_name, :note
end
