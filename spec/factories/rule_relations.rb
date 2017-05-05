# == Schema Information
#
# Table name: rule_relations
#
#  id          :integer          not null, primary key
#  rule_id     :integer
#  person_id   :integer
#  person_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :rule_relation do
    rule { create :rule }
    person { create :judge }
  end

end
