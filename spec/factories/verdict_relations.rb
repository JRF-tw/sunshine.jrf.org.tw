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

FactoryGirl.define do
  factory :verdict_relation do
    
  end

end
