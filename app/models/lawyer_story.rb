# == Schema Information
#
# Table name: lawyer_stories
#
#  id         :integer          not null, primary key
#  story_id   :integer
#  lawyer_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LawyerStory < ActiveRecord::Base
  belongs_to :lawyer
  belongs_to :story
end
