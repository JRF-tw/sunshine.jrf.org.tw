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
#  owner_id   :integer
#  owner_type :string
#

FactoryGirl.define do
  factory :education do
    owner do
      create :judge
    end
    title 'foo'
  end
end
