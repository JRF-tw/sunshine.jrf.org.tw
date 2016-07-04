require 'rails_helper'

describe Bystander::UpdateProfileContext do
  let!(:bystander) { FactoryGirl.create :bystander }
  let!(:context) { described_class.new(bystander) }

  context "success" do
    let!(:params) { { phone_number: "0911111111" } }
    subject { described_class.new(bystander).perform(params) }

    it { expect(subject).to be_truthy }
    it { expect { subject }.to change { bystander.reload.phone_number } }
  end

  describe "#parse_phone_number" do
    let!(:params) { { phone_number: "" } }
    subject { described_class.new(bystander).perform(params) }

    it { expect(subject).to be_truthy }
    it { expect { subject }.not_to change { bystander.reload.phone_number } }
  end
end
