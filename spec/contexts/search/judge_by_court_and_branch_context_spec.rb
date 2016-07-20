require "rails_helper"

describe Search::JudgeByCourtAndBranchContext do
  let!(:court) { create :court, full_name: "測試法院" }
  let!(:judge) { create :judge, name: "測試法官" }
  let!(:branch) { create :branch, name: "測試股別1", court: court, judge: judge }

  describe "#perform" do
    subject { described_class.new(court.full_name, branch.name) }

    it { expect(subject.perform).to be_truthy }
    it { expect(subject.perform).to be_a_kind_of(Array) }
    it { expect(subject.perform.count).to eq(1) }
    it { expect(subject.perform.first).to eq(judge) }
  end

  context "not find court" do
    subject { described_class.new("xxx", branch.name) }
    before { subject.perform }

    it { expect(subject.has_error?).to be_truthy }
  end

  context "not find branch" do
    subject { described_class.new(court.full_name, "xxx") }
    before { subject.perform }

    it { expect(subject.has_error?).to be_truthy }
  end
end
