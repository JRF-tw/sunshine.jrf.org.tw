require 'rails_helper'

describe Party::ResendPhoneVerifySmsContext do
  let!(:party) { FactoryGirl.create :party }
  before { party.phone_varify_code = "1111" }
  before { party.unconfirmed_phone = "0911111111" }

  subject { described_class.new(party) }

  describe "#perofrm" do
    context "check_verify_code" do
      before { party.phone_varify_code = nil }

      it { expect(subject.perform).to be_falsey }
    end

    context "check_sms_send_count" do
      before { party.sms_sent_count.value = 2 }

      it { expect(subject.perform).to be_falsey }
    end

    context "success" do
      it { expect(subject.perform).to be_truthy }
      it { expect { subject.perform }.to change_sidekiq_jobs_size_of(SmsService, :send_to) }
      it { expect { subject.perform }.to change { party.sms_sent_count.value } }
    end
  end
end
