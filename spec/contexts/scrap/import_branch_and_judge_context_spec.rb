require 'rails_helper'

RSpec.describe Scrap::ImportBranchAndJudgeContext, :type => :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH", full_name: "臺灣高等法院" }

  describe "#perform" do
    subject{ described_class.perform }
    it { expect{ subject }.to change{ court.branches.count } }
    it { expect{ subject }.to change{ Judge.count } }
  end

  describe ".perform" do
    let(:data_string) { "臺灣高等法院民事庭,乙,匡偉　法官,黃千鶴,2415" }
    subject!{ described_class.new(data_string).perform }


    it { expect(subject.name).to eq("匡偉") }
    it { expect(subject.court).to eq(court) }
    it { expect(subject.branches.last.name).to eq('乙') }
    it { expect(subject.branches.last.chamber_name).to eq('臺灣高等法院民事庭') }
  end
end
