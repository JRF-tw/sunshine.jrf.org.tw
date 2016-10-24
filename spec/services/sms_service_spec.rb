require 'rails_helper'

describe SmsService do
  let!(:phone) { '0911111111' }
  let!(:text) { 'test for send sms content' }

  describe '.send_sms' do
    subject { described_class.send_sms(phone, 'test') }
    it { expect(subject).to be_truthy }
  end

  describe '.send_slack' do
    subject { described_class.send_slack(phone, 'test') }

    it { expect(subject).to be_truthy }
  end

  describe '.send_async' do
    subject { described_class.send_async(phone, 'test') }

    it { expect { subject }.to change_sidekiq_jobs_size_of(SmsService, :send_sms) }
    it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
  end

  describe '#initialize' do
    subject { described_class.new(phone) }
    it { expect(subject.phone).to eq('+886911111111') }
  end

  describe '#send_by_slack_async' do
    context 'success async to sidekiq' do
      subject { described_class.new(phone).send_by_slack_async(text) }

      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end

  describe '#send_by_twilio' do
    context 'success ' do
      subject { described_class.new(phone).send_by_twilio(text) }

      it { expect(subject).to be_truthy }
    end
  end
end
