# == Schema Information
#
# Table name: judgment_prosecutors
#
#  id          :integer          not null, primary key
#  profile_id  :integer
#  judgment_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :judgment_prosecutor do
    prosecutor do
      create :prosecutor_profile
    end
    judgment do
      create :judgment
    end
  end

end
