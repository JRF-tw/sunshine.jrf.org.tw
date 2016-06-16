require 'rails_helper'

describe Defendant::SetToImpostorContext do
  let!(:defendent) { FactoryGirl.create :defendant, identify_number: "A225271722", name: "我愛羅" }
  subject { described_class.new(defendent) }

  describe "#perform" do
    before { subject.perform }
    context "record identify number" do
      it do 
        expect(defendent.imposter_identify_number).to eq("A225271722")
      end
    end

    context "destroy identify number" do
      it do
        expect(defendent.identify_number).to eq("")
      end
    end

    context "set to imposter" do
      it do 
        expect(defendent.imposter).to eq(true)
      end
    end
  end
end
