require 'rails_helper'

RSpec.describe Scrap::ImportCourtContext, :type => :model do
  describe ".perform" do
    subject{ described_class.perform }
    it { expect{ subject }.to change{ Court.count } }
  end

  describe "#perform" do
    context "success" do
      let(:data_hash) { { fullname: "xxx", code: "TTT" } }
      subject{ described_class.new(data_hash).perform }

      it { expect{ subject }.to change { Court.count }.by(1) }
      it { expect(subject.full_name).to eq(data_hash[:fullname]) }
      it { expect(subject.code).to eq(data_hash[:code]) }
    end

    context "update old data" do
      let!(:court) { FactoryGirl.create(:court, full_name: "xxx", code: "ABC") }
      let(:data_hash) { { fullname: "xxx", code: "TTT" } }
      subject{ described_class.new(data_hash).perform }

      it { expect{ subject }.not_to change { Court.count } }
      it { expect(subject.full_name).to eq(data_hash[:fullname]) }
      it { expect(subject.code).to eq(data_hash[:code]) }
    end

    context "data fullname incorrect" do
      let!(:court) { FactoryGirl.create(:court) }
      let(:data_hash) { { fullname: nil, code: "TTT" } }
      subject{ described_class.new(data_hash).perform }

      it { expect{ subject }.not_to change { Court.count } }
      it { expect(subject).to be_falsey }
    end

    context "data code incorrect" do
      let!(:court) { FactoryGirl.create(:court) }
      let(:data_hash) { { fullname: "xxx", code: nil } }
      subject{ described_class.new(data_hash).perform }

      it { expect{ subject }.not_to change { Court.count } }
      it { expect(subject).to be_falsey }
    end
  end
end
