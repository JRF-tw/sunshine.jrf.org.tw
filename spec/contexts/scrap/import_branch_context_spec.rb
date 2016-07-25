require "rails_helper"

RSpec.describe Scrap::ImportBranchContext, type: :model do
  let!(:court) { create(:court) }
  let!(:judge) { create(:judge, court: court) }

  describe "#perform" do
    let!(:chamber_name) { "少年法庭" }
    let!(:branch_name) { "聲" }

    context "success" do
      subject { described_class.new(judge).perform(chamber_name, branch_name) }

      it { expect { subject }.to change { judge.branches.count }.by(1) }
      it { expect(subject.judge).to eq(judge) }
      it { expect(subject.court).to eq(court) }
      it { expect(subject.chamber_name).to eq(chamber_name) }
      it { expect(subject.name).to eq(branch_name) }
    end

    context "branch exist" do
      subject! { described_class.new(judge).perform(chamber_name, branch_name) }

      it { expect { subject }.not_to change { judge.branches.count } }
    end

    context "update_branch_judge" do
      # see spec/features/judge_and_branch_update_from_scrap_spec.rb:40
    end

    context "update_missed" do
      # see spec/features/judge_and_branch_update_from_scrap_spec.rb:73
    end
  end
end
