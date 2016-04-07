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

FactoryGirl.define do
  factory :judge_story do
    judge { FactoryGirl.create :judge }
    story { FactoryGirl.create :story }
  end

end
