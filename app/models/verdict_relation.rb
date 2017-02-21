# == Schema Information
#
# Table name: verdict_relations
#
#  id          :integer          not null, primary key
#  verdict_id  :integer
#  person_id   :integer
#  person_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class VerdictRelation < ActiveRecord::Base
  belongs_to :verdict
  belongs_to :person, polymorphic: true

  validates :verdict_id, uniqueness: { scope: [:person_id, :person_type] }
  scope :by_type, ->(person_type) { where(person_type: person_type) }
end
