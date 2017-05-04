# == Schema Information
#
# Table name: schedules
#
#  id              :integer          not null, primary key
#  story_id        :integer
#  court_id        :integer
#  branch_name     :string
#  start_on        :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  branch_judge_id :integer
#  start_at        :datetime
#  courtroom       :string
#

class Schedule < ActiveRecord::Base
  belongs_to :story, counter_cache: true
  belongs_to :court
  belongs_to :branch_judge, class_name: 'Judge', foreign_key: 'branch_judge_id'
  has_many :schedule_scores
  has_many :valid_scores

  scope :newest, -> { order('id DESC') }
  scope :on_day, ->(day) { where(start_on: day) }
end
