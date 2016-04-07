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

FactoryGirl.define do
  factory :lawyer_story do
    lawyer { FactoryGirl.create :lawyer }
    story { FactoryGirl.create :story }
  end

end
