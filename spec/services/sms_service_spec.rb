require 'rails_helper'

describe SmsService do
  let!(:phone) { "0911111111" }
  let!(:text) { "test for send sms content" }

  describe "#initialize" do
    subject { described_class.new(phone) }
    it { expect(subject.phone).to eq("+886911111111") }
  end

  describe "#send_by_slack" do
    context "success async to sidekiq" do
      subject { described_class.new(phone).send_by_slack(text) }

      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end

  # describe "#send_by_twilio" do
  # end
end
