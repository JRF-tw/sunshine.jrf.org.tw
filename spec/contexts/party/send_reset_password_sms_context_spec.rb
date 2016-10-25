require 'rails_helper'

describe Party::SendResetPasswordSmsContext do
  let!(:party) { create :party }
  subject { described_class.new(params) }

  context 'success' do
    let!(:params) { { identify_number: party.identify_number, phone_number: party.phone_number } }

    it { expect { subject.perform }.to change_sidekiq_jobs_size_of(SmsService, :send_sms).by(1) }
    it { expect(subject.perform).to be_truthy }
  end

  context 'wrong identify_number' do
    let!(:params) { { identify_number: 'A111111111', phone_number: party.phone_number } }

    it { expect { subject.perform }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
    it { expect(subject.perform).to be_falsey }
  end

  context 'nil identify_number' do
    let!(:params) { { identify_number: nil, phone_number: party.phone_number } }

    it { expect(subject.perform).to be_falsey }
  end

  context 'empty identify_number' do
    let!(:params) { { identify_number: '', phone_number: party.phone_number } }

    it { expect(subject.perform).to be_falsey }
  end

  context 'wrong phone_number' do
    let!(:params) { { identify_number: party.identify_number, phone_number: '09xxxxxxxx' } }

    it { expect(subject.perform).to be_falsey }
  end

  context 'phone_number unconfirmed' do
    before { party.unconfirmed_phone.value = '0911111111' }
    let!(:params) { { identify_number: party.identify_number, phone_number: '0911111111' } }

    it { expect(subject.perform).to be_falsey }
  end

  context 'nil phone_number' do
    let!(:params) { { identify_number: party.identify_number, phone_number: nil } }

    it { expect(subject.perform).to be_falsey }
  end

  context 'nil phone_number' do
    let!(:params) { { identify_number: party.identify_number, phone_number: '' } }

    it { expect(subject.perform).to be_falsey }
  end

  context 'empty input' do
    let!(:params) { { identify_number: '', phone_number: '' } }

    it { expect(subject.perform).to be_falsey }
  end

  context 'nil input' do
    let!(:params) { { identify_number: nil, phone_number: nil } }

    it { expect(subject.perform).to be_falsey }
  end
end
