require 'rails_helper'

RSpec.describe Scrap::CreateBranchContext, :type => :model do
  let!(:court) { FactoryGirl.create(:court) }
  let!(:judge) { FactoryGirl.create(:judge, court: court) }

  describe "#perform" do
    let!(:chamber_name) { "少年法庭" }
    let!(:branch_name) { "聲" }

    context "success" do
      subject{ described_class.new(judge).perform(chamber_name, branch_name) }

      it { expect{ subject }.to change { judge.branches.count }.by(1) }
      it { expect(subject.judge).to eq(judge) }
      it { expect(subject.court).to eq(court) }
      it { expect(subject.chamber_name).to eq(chamber_name) }
      it { expect(subject.name).to eq(branch_name) }
    end

    context "branch exist" do
      subject!{ described_class.new(judge).perform(chamber_name, branch_name) }

      it { expect{ subject }.not_to change { judge.branches.count } }
    end
  end
end
