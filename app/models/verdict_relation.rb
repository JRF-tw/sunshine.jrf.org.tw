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
end
