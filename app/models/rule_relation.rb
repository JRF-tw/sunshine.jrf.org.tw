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

class RuleRelation < ActiveRecord::Base
  belongs_to :rule
  belongs_to :person, polymorphic: true

  validates :rule_id, uniqueness: { scope: [:person_id, :person_type] }
end
