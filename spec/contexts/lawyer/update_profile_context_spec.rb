require "rails_helper"

describe Lawyer::UpdateProfileContext do
  let!(:lawyer) { create :lawyer }
  let!(:context) { described_class.new(lawyer) }

  context "success" do
    let!(:params) { { phone_number: "0911111111" } }
    subject { described_class.new(lawyer).perform(params) }

    it { expect(subject).to be_truthy }
    it { expect { subject }.to change { lawyer.reload.phone_number } }
  end

  describe "#parse_number" do
    let!(:params) { { phone_number: "" } }
    subject { described_class.new(lawyer).perform(params) }

    it { expect(subject).to be_truthy }
    it { expect { subject }.not_to change { lawyer.reload.phone_number } }
  end
end
