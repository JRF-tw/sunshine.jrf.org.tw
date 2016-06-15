require 'rails_helper'

describe Defendant::ResendPhoneVerifySmsContext do
  let!(:defendant) { FactoryGirl.create :defendant }
  before { defendant.phone_varify_code = "1111" }
  before { defendant.unconfirmed_phone = "0911111111" }

  subject { described_class.new(defendant) }

  describe "#perofrm" do
    context "check_verify_code" do
      before { defendant.phone_varify_code = nil }

      it { expect(subject.perform).to be_falsey }
    end

    context "check_sms_send_count" do
      before { defendant.sms_sent_count.value = 2 }

      it { expect(subject.perform).to be_falsey }
    end

    context "success" do
      it { expect(subject.perform).to be_truthy }
      it { expect { subject.perform }.to change_sidekiq_jobs_size_of(SmsService, :send_to) }
      it { expect { subject.perform }.to change { defendant.sms_sent_count.value } }
    end
  end
end
