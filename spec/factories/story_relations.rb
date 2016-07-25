# == Schema Information
#
# Table name: story_relations
#
#  id          :integer          not null, primary key
#  story_id    :integer
#  people_id   :integer
#  people_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :story_relation do
    story { create :story }
    people { create :judge }
  end
end
