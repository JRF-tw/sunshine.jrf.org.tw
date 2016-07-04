require 'rails_helper'

RSpec.describe VerdictRelation, type: :model do
  describe "FactoryGirl" do
    describe "normalize" do
      let!(:verdict_relation) { FactoryGirl.create :verdict_relation }
      it { expect(verdict_relation).to be_present }
      it { expect(verdict_relation.person).to eq(Judge.last) }
    end
  end
end
