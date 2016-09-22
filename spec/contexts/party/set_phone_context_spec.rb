require "rails_helper"

describe Party::SetPhoneContext do
  let!(:party) { create :party }
  let!(:params) { { unconfirmed_phone: "0911111111" } }
  subject { described_class.new(party) }

  describe "#perform" do
    context "check_phone" do
      let!(:params) { { unconfirmed_phone: "" } }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "check_phone_format" do
      let!(:params) { { unconfirmed_phone: "092112312x" } }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "check_unexist_phone_number" do
      let!(:party1) { create :party, phone_number: params[:unconfirmed_phone] }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "check_phone_not_the_same" do
      let!(:party1) { create :party }
      let!(:params) { { unconfirmed_phone: party.phone_number } }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "check_unexist_unconfirmed_phone" do
      let!(:party1) { create :party }
      before { party1.unconfirmed_phone = params[:unconfirmed_phone] }

      it { expect(subject.perform(params)).to be_falsey }
    end

    context "check_sms_send_count" do
      before { party.sms_sent_count.value = 2 }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "success" do
      it { expect { subject.perform(params) }.to change { party.sms_sent_count.value } }
      it { expect { subject.perform(params) }.to change_sidekiq_jobs_size_of(SmsService, :send_sms) }

      context "assign_value" do
        before { subject.perform(params) }

        it { expect(party.phone_varify_code.value).to be_present }
        it { expect(party.unconfirmed_phone).to eq(params[:unconfirmed_phone]) }
      end

      context "set_unconfirm" do
        before { subject.perform(params) }

        it { expect(party.confirmed?).to be_falsey }
      end
    end
  end
end
