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
#

FactoryGirl.define do
  factory :license do
    profile do
      FactoryGirl.create :profile
    end
    license_type "haha"
    unit "foo"
    title "bar"
  end
end
