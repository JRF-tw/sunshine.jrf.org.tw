# == Schema Information
#
# Table name: awards
#
#  id          :integer          not null, primary key
#  profile_id  :integer
#  award_type  :string(255)
#  unit        :string(255)
#  content     :text
#  publish_at  :date
#  source      :text
#  source_link :string(255)
#  origin_desc :text
#  memo        :text
#  created_at  :datetime
#  updated_at  :datetime
#  is_hidden   :boolean
#

FactoryGirl.define do
  factory :award do
    profile do
      FactoryGirl.create :profile
    end
    award_type "嘉獎一次"
    unit "司法院"
    publish_at Date.today
  end

end
