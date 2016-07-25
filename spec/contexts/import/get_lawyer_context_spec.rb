require "rails_helper"

describe Import::GetLawyerContext do
  let(:lawyer_data) { SmarterCSV.process("spec/fixtures/lawyers.csv") }
  subject { described_class.new(lawyer_data).perform }

  describe "#perform" do
    context "import four lawyers" do
      it { expect { subject }.to change { Lawyer.count }.by(4) }
    end
  end
end
