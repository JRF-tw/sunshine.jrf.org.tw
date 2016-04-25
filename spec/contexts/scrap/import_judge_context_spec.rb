require 'rails_helper'

RSpec.describe Scrap::ImportJudgeContext, :type => :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH", full_name: "臺灣高等法院" }

  describe ".perform" do
    subject{ described_class.perform }
    it { expect{ subject }.to change{ court.branches.count } }
    it { expect{ subject }.to change{ Judge.count } }
  end

  describe "#perform" do
    context "success" do
      let(:data_string) { "臺灣高等法院民事庭,乙,匡偉　法官,黃千鶴,2415" }
      subject{ described_class.new(data_string).perform }

      it { expect(subject.name).to eq("匡偉") }
      it { expect(subject.court).to eq(court) }
      it { expect(subject.branches.last.name).to eq('乙') }
      it { expect(subject.branches.last.chamber_name).to eq('臺灣高等法院民事庭') }
      it { expect{ subject }.to change{ Judge.count }.by(1) }
    end

    context "judge exist" do
      let!(:judge){ FactoryGirl.create :judge, court: court, name: "匡偉"}
      let(:data_string) { "臺灣高等法院民事庭,乙,匡偉　法官,黃千鶴,2415" }
      subject{ described_class.new(data_string).perform }

      it { expect{ subject }.not_to change{ Judge.count } }
    end

    context "court not exist" do
      let(:data_string) { "xxxxxx,乙,匡偉　法官,黃千鶴,2415" }
      subject{ described_class.new(data_string).perform }

      it { expect(subject).to be_falsey }
    end

    context "create_branch" do
      let(:data_string) { "臺灣高等法院民事庭,乙,匡偉　法官,黃千鶴,2415" }
      subject{ described_class.new(data_string).perform }

      it { expect{ subject }.to change{ Branch.count } }
    end
  end
end
