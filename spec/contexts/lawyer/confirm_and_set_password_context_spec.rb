require "rails_helper"

describe Lawyer::ConfirmAndSetPasswordContext do
  let!(:lawyer) { FactoryGirl.create :lawyer, confirmation_token: "hello" }

  describe "perform" do
    context "success" do
      subject { described_class.new(lawyer: { confirmation_token: lawyer.confirmation_token, password: "12345678", password_confirmation: "12345678" }) }
      it { expect { subject.perform }.to change { lawyer.reload.confirmed? } }
      it { expect { subject.perform }.to change { lawyer.reload.encrypted_password } }
    end

    context "empty password" do
      subject { described_class.new(lawyer: { confirmation_token: lawyer.confirmation_token, password: "", password_confirmation: "" }) }
      it { expect { subject.perform }.not_to change { lawyer.reload.confirmed? } }
      it { expect { subject.perform }.not_to change { lawyer.reload.encrypted_password } }
    end

    context "invalidate password" do
      subject { described_class.new(lawyer: { confirmation_token: "2222", password: "123", password_confirmation: "123" }) }
      it { expect { subject.perform }.not_to change { lawyer.reload.confirmed? } }
    end

    context "invalidate token" do
      subject { described_class.new(lawyer: { confirmation_token: "2222", password: "12345678", password_confirmation: "12345678" }) }
      it { expect { subject.perform }.not_to change { lawyer.reload.confirmed? } }
    end
  end
end
