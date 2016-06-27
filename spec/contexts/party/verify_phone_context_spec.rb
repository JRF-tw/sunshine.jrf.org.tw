require 'rails_helper'

describe Party::VerifyPhoneContext do
  let!(:unconfirmed_phone) { "0911111111" }
  let!(:party) { FactoryGirl.create :party }
  let!(:params) { { phone_varify_code: "1111" } }
  before { party.phone_varify_code = "1111" }
  before { party.unconfirmed_phone = unconfirmed_phone }

  subject { described_class.new(party) }

  describe "#perform" do
    context "record_retry_count" do
      let!(:params) { { phone_varify_code: "2222" } }
      it { expect { subject.perform(params) }.to change { party.retry_verify_count.value } }
    end

    context "reset_phone_verify" do
      let!(:params) { { phone_varify_code: "2222" } }
      before { party.retry_verify_count.value = 2 }

      it { expect(subject.perform(params)).to be_falsey }
    end

    context "check_sms_send_count" do
      let!(:params) { { phone_varify_code: "2222" } }
      before { party.sms_sent_count.value = 2 }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "success" do
      it { expect { subject.perform(params) }.to change { party.phone_number } }

      context "assign_value" do
        before { subject.perform(params) }

        it { expect(party.phone_number).to eq(unconfirmed_phone) }
        it { expect(party.unconfirmed_phone.value).to be_nil }
      end

      context "phone_confirmed?" do
        before { subject.perform(params) }

        it { expect(party.phone_confirmed?).to be_truthy }
      end

      context "reset_data" do
        before { subject.perform(params) }

        it { expect(party.unconfirmed_phone).to be_nil }
        it { expect(party.phone_varify_code.value).to be_nil }
        it { expect(party.retry_verify_count.value).to eq(0) }
      end
    end
  end
end
