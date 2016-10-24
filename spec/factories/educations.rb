# == Schema Information
#
# Table name: educations
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  title      :string
#  content    :text
#  start_at   :date
#  end_at     :date
#  source     :text
#  memo       :text
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean
#

FactoryGirl.define do
  factory :education do
    profile do
      create :profile
    end
    title 'foo'
  end
end
