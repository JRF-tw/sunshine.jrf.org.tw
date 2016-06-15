require 'rails_helper'

describe Defendant::SetPhoneContext do
  let!(:defendant) { FactoryGirl.create :defendant }
  let!(:params) { { phone_number: "0911111111" } }
  subject { described_class.new(defendant) }

  describe "#perform" do
    context "check_unexist_phone_number" do
      let!(:defendant1) { FactoryGirl.create :defendant, phone_number: params[:phone_number] }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "check_unexist_unconfirmd_phone" do
      let!(:defendant1) { FactoryGirl.create :defendant, unconfirmed_phone: params[:phone_number] }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "check_sms_send_count" do
      before { defendant.sms_sent_count.value = 2 }
      it { expect(subject.perform(params)).to be_falsey }
    end

    context "success" do
      it { expect { subject.perform(params) }.to change { defendant.sms_sent_count.value } }
      it { expect { subject.perform(params) }.to change_sidekiq_jobs_size_of(SmsService, :send_to) }

      context "assign_value" do
        before { subject.perform(params) }

        it { expect(defendant.phone_varify_code.value).to be_present }
        it { expect(defendant.unconfirmed_phone).to eq(params[:phone_number]) }
      end

      context "set_unconfirm" do
        before { subject.perform(params) }

        it { expect(defendant.confirmed?).to be_falsey }
      end
    end
  end
end
