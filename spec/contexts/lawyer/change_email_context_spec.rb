require "rails_helper"

describe Lawyer::ChangeEmailContext do
  let!(:lawyer) { create :lawyer, :with_password }
  let!(:new_email) { "h2312@gmail.com" }
  subject { described_class.new(lawyer) }

  describe "perform" do
    context "success" do
      let(:params) { { email: new_email, current_password: "123123123" } }

      it { expect { subject.perform(params) }.to change { lawyer.reload.unconfirmed_email } }
    end

    context "update the invalid email" do
      let(:params) { { email: "h2312", current_password: "123123123" } }

      it { expect { subject.perform(params) }.not_to change { lawyer.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:email_pattern_invalid] } }
    end

    context "update the same email" do
      let(:params) { { email: lawyer.email, current_password: "123123123" } }

      it { expect { subject.perform(params) }.not_to change { lawyer.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:email_conflict] } }
    end

    context "update other's email" do
      let!(:lawyer2) { create :lawyer }
      let(:params) { { email: lawyer2.email, current_password: "123123123" } }

      it { expect { subject.perform(params) }.not_to change { lawyer.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:email_exist] } }
    end

    context "update other's unconfirmed_email" do
      let!(:lawyer2) { create :lawyer, :with_unconfirmed_email }
      let(:params) { { email: lawyer2.unconfirmed_email, current_password: "123123123" } }

      it { expect { subject.perform(params) }.to change { lawyer.reload.unconfirmed_email } }
    end

    context "empty password" do
      let(:params) { { email: new_email, current_password: "" } }

      it { expect { subject.perform(params) }.not_to change { lawyer.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:wrong_password] } }
    end

    context "empty wrong password" do
      let(:params) { { email: new_email, current_password: "55665566" } }

      it { expect { subject.perform(params) }.not_to change { lawyer.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:wrong_password] } }
    end

  end
end
