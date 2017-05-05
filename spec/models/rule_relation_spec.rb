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

require 'rails_helper'

RSpec.describe RuleRelation, type: :model do
  describe 'FactoryGirl' do
    describe 'normalize' do
      let!(:rule_relation) { create :rule_relation }
      it { expect(rule_relation).to be_present }
      it { expect(rule_relation.person).to eq(Judge.last) }
    end
  end
end
