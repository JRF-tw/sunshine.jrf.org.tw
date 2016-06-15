require 'rails_helper'

describe Defendant::SetToImpostorContext do
  let!(:defendent) { FactoryGirl.create :defendant }
  subject { described_class.new(defendent) }

  describe "#perform" do
    context "change name" do
      it { expect { subject.perform }.to change { defendent.name } }
    end

    context "record identify number" do
      it { expect { subject.perform }.to change { defendent.imposter_identify_number } }
    end

    context "destroy identify number" do
      it { expect { subject.perform }.to change { defendent.identify_number } }
    end

    context "set to imposter" do
      it { expect { subject.perform }.to change { defendent.imposter } }
    end
  end
end
