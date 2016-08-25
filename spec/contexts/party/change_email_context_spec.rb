require "rails_helper"

describe Party::ChangeEmailContext do
  let!(:party) { create :party, unconfirmed_email: "hh@gmail.com" }
  let!(:new_email) { "h2312@gmail.com" }
  subject { described_class.new(party) }

  describe "perform" do
    context "success" do
      let(:params) { { email: new_email, current_password: "12321313213" } }

      it { expect { subject.perform(params) }.to change { party.reload.unconfirmed_email } }
    end

    context "email already exist" do
      let!(:party2) { create :party, email: "55667788@gmail.com" }
      let(:params) { { email: party2.email, current_password: "12321313213" } }

      it { expect { subject.perform(params) }.not_to change { party.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:party_exist] } }
    end

    context "empty email" do
      let(:params) { { email: "", current_password: "12321313213" } }

      it { expect { subject.perform(params) }.not_to change { party.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:data_invalid] } }
    end

    context "empty password" do
      let(:params) { { email: new_email, current_password: "" } }

      it { expect { subject.perform(params) }.not_to change { party.reload.unconfirmed_email } }
    end

    context "empty wrong password" do
      let(:params) { { email: new_email, current_password: "5566nice" } }

      it { expect { subject.perform(params) }.not_to change { party.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:data_update_fail] } }
    end

    context "update invalid email" do
      let(:params) { { email: "5566ee", current_password: "12321313213" } }

      it { expect { subject.perform(params) }.not_to change { party.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:data_invalid] } }
    end

    context "update the same email" do
      let(:params) { { email: party.email, current_password: "12321313213" } }

      it { expect { subject.perform(params) }.not_to change { party.reload.unconfirmed_email } }
      it { expect { subject.perform(params) }.to change { subject.errors[:email_conflict] } }
    end

    context "update other's unconfirmed_email" do
      let!(:party2) { create :party, unconfirmed_email: "55667788@gmail.com" }
      let(:params) { { email: party2.unconfirmed_email, current_password: "12321313213" } }

      it { expect { subject.perform(params) }.to change { party.reload.unconfirmed_email } }
    end
  end

end
