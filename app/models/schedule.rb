# == Schema Information
#
# Table name: schedules
#
#  id            :integer          not null, primary key
#  story_id      :integer
#  court_id      :integer
#  branch_name   :string
#  date          :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  main_judge_id :integer
#

class Schedule < ActiveRecord::Base
  belongs_to :story
  belongs_to :court
  belongs_to :main_judge, class_name: "Judge", foreign_key: "main_judge_id"

  scope :newest, ->{ order("id DESC") }
end
