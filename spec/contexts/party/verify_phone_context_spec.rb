require 'rails_helper'

describe Party::VerifyPhoneContext do
  before { party.phone_varify_code = "1111" }

  describe "#perform" do
    context "fails" do
      let(:verify_form_with_wrong_code) { create :party_verify_phone_form_object, phone_varify_code: "2222" }
      let(:party) { verify_form_with_wrong_code.party }
      subject { described_class.new(verify_form_with_wrong_code) }

      context "record_retry_count" do
        it { expect { subject.perform }.to change { party.retry_verify_count.value } }
      end

      context "reset_phone_verify" do
        before { party.retry_verify_count.value = 2 }

        it { expect(subject.perform).to be_falsey }
      end

      context "check_sms_send_count" do
        before { party.sms_sent_count.value = 2 }
        it { expect(subject.perform).to be_falsey }
      end
    end

    context "success" do
      let(:verify_form) { create :party_verify_phone_form_object, unconfirmed_phone: "0911111111", phone_varify_code: "1111" }
      let(:party) { verify_form.party }
      subject { described_class.new(verify_form) }

      it { expect { subject.perform }.to change { party.phone_number } }

      context "assign_value" do
        before { subject.perform }

        it { expect(party.phone_number).to eq("0911111111") }
        it { expect(party.unconfirmed_phone.value).to be_nil }
      end

      context "phone_confirmed?" do
        before { subject.perform }

        it { expect(party.phone_confirmed?).to be_truthy }
      end

      context "reset_data" do
        before { subject.perform }

        it { expect(party.unconfirmed_phone).to be_nil }
        it { expect(party.phone_varify_code.value).to be_nil }
        it { expect(party.retry_verify_count.value).to eq(0) }
      end
    end
  end
end
