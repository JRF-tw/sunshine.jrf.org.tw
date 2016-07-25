# == Schema Information
#
# Table name: suit_judges
#
#  id         :integer          not null, primary key
#  suit_id    :integer
#  profile_id :integer
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :suit_judge do
    judge do
      create :judge_profile
    end
    suit do
      create :suit
    end
  end

end
