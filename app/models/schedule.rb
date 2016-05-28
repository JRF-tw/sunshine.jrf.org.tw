# == Schema Information
#
# Table name: schedules
#
#  id              :integer          not null, primary key
#  story_id        :integer
#  court_id        :integer
#  branch_name     :string
#  date            :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  branch_judge_id :integer
#

class Schedule < ActiveRecord::Base
  belongs_to :story
  belongs_to :court
  belongs_to :branch_judge, class_name: "Judge", foreign_key: "branch_judge_id"

  scope :newest, ->{ order("id DESC") }
end
