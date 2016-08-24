require "rails_helper"

describe Lawyer::ChangeEmailContext do
  let!(:lawyer) { create :lawyer, :with_password }

  describe "perform" do
    context "success" do
      let(:params) { { email: "h2312@gmail.com", current_password: "123123123" } }
      subject { described_class.new(lawyer) }

      it { expect { subject.perform(params) }.to change { lawyer.reload.unconfirmed_email } }
    end

    context "update the invalid email" do
      let(:params) { { email: "h2312", current_password: "123123123" } }
      subject { described_class.new(lawyer) }

      it { expect { subject.perform(params) }.not_to change { lawyer.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:data_invalid] } }
    end

    context "update the same email" do
      let(:params) { { email: lawyer.email, current_password: "123123123" } }
      subject { described_class.new(lawyer) }

      it { expect { subject.perform(params) }.not_to change { lawyer.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:email_conflict] } }
    end

    context "update other's email" do
      let!(:lawyer2) { create :lawyer }
      let(:params) { { email: lawyer2.email, current_password: "123123123" } }
      subject { described_class.new(lawyer) }

      it { expect { subject.perform(params) }.not_to change { lawyer.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:lawyer_exist] } }
    end

    context "update other's unconfirmed_email" do
      let!(:lawyer2) { create :lawyer, :with_unconfirmed_email }
      let(:params) { { email: lawyer2.unconfirmed_email, current_password: "123123123" } }
      subject { described_class.new(lawyer) }

      it { expect { subject.perform(params) }.to change { lawyer.reload.unconfirmed_email } }
    end

    context "empty password" do
      let(:params) { { email: lawyer.email, current_password: "" } }
      subject { described_class.new(lawyer) }

      it { expect { subject.perform(params) }.not_to change { lawyer.reload.unconfirmed_email } }
    end
  end

end
