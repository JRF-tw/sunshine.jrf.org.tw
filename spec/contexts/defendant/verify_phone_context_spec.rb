require 'rails_helper'

describe Defendant::VerifyPhoneContext do
  let!(:defendant) { FactoryGirl.create :defendant }
  let!(:params) { { phone_varify_code: "1111" } }
  before { defendant.phone_varify_code = "1111" }
  subject { described_class.new(defendant) }

  describe "#perform" do
    context "record_retry_count" do
      let!(:params) { { phone_varify_code: "2222" } }
      it { expect { subject.perform(params) }.to change { defendant.retry_verify_count.value } }
    end

    context "reset_phone_verify" do
      let!(:params) { { phone_varify_code: "2222" } }

      let!(:defendant1) { FactoryGirl.create :defendant, unconfirmed_phone: params[:phone_number] }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "check_sms_send_count" do
      let!(:params) { { phone_varify_code: "2222" } }
      before { defendant.sms_sent_count.value = 2 }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "success" do
      it { expect { subject.perform(params) }.to change { defendant.sms_sent_count.value } }
      it { expect { subject.perform(params) }.to change_sidekiq_jobs_size_of(SmsService, :send_to) }
      it { expect { subject.perform(params) }.to change { defendant.phone_number } }

      context "assign_value" do
        before { subject.perform(params) }

        it { expect(defendant.phone_varify_code.value).to be_present }
        it { expect(defendant.unconfirmed_phone).to eq(params[:phone_number]) }
      end

      context "set_unconfirm" do
        before { subject.perform(params) }

        it { expect(defendant.confirmed?).to be_falsey }
      end

      context "reset_data" do
        before { subject.perform(params) }

        it { expect(defendant.phone_varify_code.value).to be_nil }
        it { expect(defendant.retry_verify_count.value).to eq(0) }
        it { expect(defendant.unconfirmed_phone).to be_nil }
      end
    end
  end
end
