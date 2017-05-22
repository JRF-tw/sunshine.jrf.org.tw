# == Schema Information
#
# Table name: careers
#
#  id                  :integer          not null, primary key
#  profile_id          :integer
#  career_type         :string
#  old_unit            :string
#  old_title           :string
#  old_assign_court    :string
#  old_assign_judicial :string
#  old_pt              :string
#  new_unit            :string
#  new_title           :string
#  new_assign_court    :string
#  new_assign_judicial :string
#  new_pt              :string
#  start_at            :date
#  end_at              :date
#  publish_at          :date
#  source              :text
#  source_link         :text
#  origin_desc         :text
#  memo                :text
#  created_at          :datetime
#  updated_at          :datetime
#  is_hidden           :boolean
#

FactoryGirl.define do
  factory :career do
    owner do
      create :judge
    end
    career_type '調派'
    publish_at Time.zone.today
  end

end
