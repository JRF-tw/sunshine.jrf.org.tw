require 'rails_helper'

describe Party::SetPhoneContext do
  let!(:party) { create :party }
  subject { described_class.new(party) }

  describe "#perform" do
    context "fail" do
      context "check_phone" do
        let(:params) { { phone_form: { unconfirmed_phone: "" } } }
        before { subject.perform(params) }
        it { expect(subject.has_error?).to be_truthy }
      end

      context "check_phone_format" do
        let(:params) { { phone_form: { unconfirmed_phone: "092112312x" } } }
        before { subject.perform(params) }
        it { expect(subject.has_error?).to be_truthy }
      end

      context "check_unexist_phone_number" do
        let!(:party1) { create :party, phone_number: "0911222333" }
        let(:params) { { phone_form: { unconfirmed_phone: party1.phone_number } } }
        before { subject.perform(params) }
        it { expect(subject.has_error?).to be_truthy }
      end

      context "check_phone_not_the_same" do
        let(:params) { { phone_form: { unconfirmed_phone: party.phone_number } } }
        before { subject.perform(params) }
        it { expect(subject.has_error?).to be_truthy }
      end

      context "check_unexist_unconfirmed_phone" do
        let(:params) { { phone_form: { unconfirmed_phone: "0911222333" } } }
        let!(:party1) { create :party, phone_number: "0911222333" }
        before { party1.unconfirmed_phone = "0911222333" }
        before { subject.perform(params) }
        it { expect(subject.has_error?).to be_truthy }
      end

      context "check_sms_send_count" do
        let(:params) { { phone_form: { unconfirmed_phone: "0911222333" } } }
        before { party.sms_sent_count.value = 2 }
        before { subject.perform(params) }
        it { expect(subject.has_error?).to be_truthy }
      end
    end

    context "success" do
      let(:params) { { phone_form: { unconfirmed_phone: "0911222333" } } }
      it { expect { subject.perform(params) }.to change { party.sms_sent_count.value } }
      it { expect { subject.perform(params) }.to change_sidekiq_jobs_size_of(SmsService, :send_sms) }
      context "assign_value" do
        before { subject.perform(params) }
        it { expect(party.phone_varify_code.value).to be_present }
        it { expect(party.unconfirmed_phone).to eq("0911222333") }
      end

      context "set_unconfirm" do
        before { subject.perform(params) }
        it { expect(party.confirmed?).to be_falsey }
      end
    end
  end
end
