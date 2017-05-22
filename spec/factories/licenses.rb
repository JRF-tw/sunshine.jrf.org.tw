# == Schema Information
#
# Table name: licenses
#
#  id           :integer          not null, primary key
#  profile_id   :integer
#  license_type :string
#  unit         :string
#  title        :string
#  publish_at   :date
#  source       :text
#  source_link  :text
#  origin_desc  :text
#  memo         :text
#  created_at   :datetime
#  updated_at   :datetime
#  is_hidden    :boolean
#  owner_id     :integer
#  owner_type   :string
#

FactoryGirl.define do
  factory :license do
    owner do
      create :judge
    end
    license_type 'haha'
    unit 'foo'
    title 'bar'
  end
end
