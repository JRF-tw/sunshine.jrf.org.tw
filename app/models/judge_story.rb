# == Schema Information
#
# Table name: judge_stories
#
#  id         :integer          not null, primary key
#  story_id   :integer
#  judge_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class JudgeStory < ActiveRecord::Base
  belongs_to :judge
  belongs_to :story
end
