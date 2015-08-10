# == Schema Information
#
# Table name: suit_prosecutors
#
#  id         :integer          not null, primary key
#  suit_id    :integer
#  profile_id :integer
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :suit_prosecutor do
    prosecutor do
      FactoryGirl.create :prosecutor_profile
    end
    suit do
      FactoryGirl.create :suit
    end
  end

end
