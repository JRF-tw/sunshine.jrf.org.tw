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

require "rails_helper"

RSpec.describe VerdictRelation, type: :model do
  describe "FactoryGirl" do
    describe "normalize" do
      let!(:verdict_relation) { create :verdict_relation }
      it { expect(verdict_relation).to be_present }
      it { expect(verdict_relation.person).to eq(Judge.last) }
    end
  end
end
