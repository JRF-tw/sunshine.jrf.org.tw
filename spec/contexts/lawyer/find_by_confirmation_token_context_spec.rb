require "rails_helper"

describe Lawyer::FindByConfirmationTokenContext do
  let!(:lawyer) { FactoryGirl.create :lawyer }

  describe "perform" do
    context "success" do
      subject { described_class.new(lawyer: { confirmation_token: lawyer.confirmation_token }) }
      it { expect(subject.perform).to eq(lawyer) }
    end

    context "lawyer not exist" do
      subject { described_class.new(lawyer: { confirmation_token: "aaaa" }) }
      it { expect { subject.perform }.to change { subject.errors[:lawyer_not_found] } }
    end
  end

end
