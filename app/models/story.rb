# == Schema Information
#
# Table name: stories
#
#  id            :integer          not null, primary key
#  court_id      :integer
#  main_judge_id :integer
#  story_type    :string
#  year          :integer
#  word_type     :string
#  number        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Story < ActiveRecord::Base
  has_many :judge_stories
  has_many :judges, through: :judge_stories
  has_many :lawyer_stories
  has_many :lawyer, through: :lawyer_stories
  has_many :schedules
  has_many :verdicts
  belongs_to :court

  scope :newest, ->{ order("id DESC") }
end
