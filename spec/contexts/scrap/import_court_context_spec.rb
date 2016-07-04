require 'rails_helper'

RSpec.describe Scrap::ImportCourtContext, type: :model do

  describe "#perform" do
    let(:data_hash) { { scrap_name: "xxx", code: "TTT" } }
    subject { described_class.new(data_hash).perform }

    context "find court" do
      context "code match" do
        let!(:court) { FactoryGirl.create(:court, code: "TTT") }
        it { expect { subject }.not_to change { Court.count } }
      end

      context "scrap_name match" do
        let!(:court) { FactoryGirl.create(:court, scrap_name: "xxx") }
        it { expect { subject }.not_to change { Court.count } }
      end

      context "trip scrap_name match full_name" do
        let!(:court) { FactoryGirl.create(:court, full_name: "xxx") }
        let(:data_hash) { { scrap_name: "x x  x", code: "TTT" } }
        it { expect { subject }.not_to change { Court.count } }
      end
    end

    context "create court" do
      it { expect { subject }.to change { Court.count }.by(1) }
    end

    context "update_name" do
      context "exist" do
        let!(:court) { FactoryGirl.create(:court, code: "TTT") }
        before { subject }

        it { expect(court.name).not_to eq(data_hash[:scrap_name]) }
      end

      context "unexist" do
        let!(:court) { FactoryGirl.create(:court, name: nil, code: "TTT") }
        before { subject }

        it { expect(court.reload.name).to eq(data_hash[:scrap_name]) }
      end
    end

    context "update_full_name" do
      context "exist" do
        let!(:court) { FactoryGirl.create(:court, code: "TTT") }
        before { subject }

        it { expect(court.reload.full_name).not_to eq(data_hash[:scrap_name]) }
      end

      context "unexist" do
        let!(:court) { FactoryGirl.create(:court, full_name: nil, code: "TTT") }
        before { subject }

        it { expect(court.reload.full_name).to eq(data_hash[:scrap_name]) }
      end
    end

    context "update_scrap_name" do
      let!(:court) { FactoryGirl.create(:court, scrap_name: "blablabla", code: "TTT") }
      before { subject }

      it { expect(court.reload.scrap_name).to eq(data_hash[:scrap_name]) }
    end

    context "update_code" do
      let!(:court) { FactoryGirl.create(:court, scrap_name: "xxx", code: "ABC") }
      before { subject }

      it { expect(court.reload.code).to eq(data_hash[:code]) }
    end

    context "assign default value" do
      before { subject }

      it { expect(subject.court_type).to eq("法院") }
    end

    context "notify_diff_fullname" do
      # see spec/features/courts_update_from_scrap_spec.rb:22
    end
  end
end
