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

class Admin::Story < ::Story
  has_many :judge_stories
  has_many :judges, through: :judge_stories
  has_many :lawyer_stories
  has_many :lawyer, through: :lawyer_stories
  belongs_to :court, class_name: "Admin::Court"
  has_many :schedules, class_name: "Admin::Schedule"

  STORY_TYPES = [
    "民事",
    "邢事"
  ]
end 
  
