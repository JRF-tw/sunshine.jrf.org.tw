# == Schema Information
#
# Table name: judgment_judges
#
#  id          :integer          not null, primary key
#  profile_id  :integer
#  judgment_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :judgment_judge do
    judge do
      FactoryGirl.create :judge_profile
    end
    judgment do
      FactoryGirl.create :judgment
    end
  end

end
