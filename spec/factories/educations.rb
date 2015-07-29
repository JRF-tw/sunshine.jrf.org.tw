# == Schema Information
#
# Table name: educations
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  title      :string(255)
#  content    :text
#  start_at   :date
#  end_at     :date
#  source     :string(255)
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :education do
    profile do
      FactoryGirl.create :profile
    end
    title 'foo'
  end
end
