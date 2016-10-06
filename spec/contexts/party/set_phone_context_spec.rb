require 'rails_helper'

describe Party::SetPhoneContext do
  let!(:phone_form) { create :party_change_phone_form_object, unconfirmed_phone: '0911111111' }
  subject { described_class.new(phone_form) }

  describe '#perform' do
    context 'check_phone' do
      let!(:phone_form) { create :party_change_phone_form_object, unconfirmed_phone: '' }
      it { expect(subject.perform).to be_falsey }
    end

    context 'check_phone_format' do
      let!(:phone_form) { create :party_change_phone_form_object, unconfirmed_phone: '092112312x' }
      it { expect(subject.perform).to be_falsey }
    end

    context 'check_unexist_phone_number' do
      let!(:party1) { create :party, phone_number: '0911222333' }
      let!(:phone_form) { create :party_change_phone_form_object, unconfirmed_phone: '0911222333' }
      it { expect(subject.perform).to be_falsey }
    end

    context 'check_phone_not_the_same' do
      before { phone_form.unconfirmed_phone = phone_form.phone_number }
      it { expect(subject.perform).to be_falsey }
    end

    context 'check_unexist_unconfirmed_phone' do
      let!(:party1) { create :party }
      before { party1.unconfirmed_phone = '0911222333' }
      let!(:phone_form) { create :party_change_phone_form_object, unconfirmed_phone: '0911222333' }

      it { expect(subject.perform).to be_falsey }
    end

    context 'check_sms_send_count' do
      before { phone_form.party.sms_sent_count.value = 2 }
      it { expect(subject.perform).to be_falsey }
    end

    context 'success' do
      it { expect { subject.perform }.to change { phone_form.party.sms_sent_count.value } }
      it { expect { subject.perform }.to change_sidekiq_jobs_size_of(SmsService, :send_sms) }

      context 'assign_value' do
        before { subject.perform }

        it { expect(phone_form.party.phone_varify_code.value).to be_present }
        it { expect(phone_form.party.unconfirmed_phone).to eq(phone_form.unconfirmed_phone) }
      end


      context 'set_unconfirm' do
        before { subject.perform }

        it { expect(phone_form.party.confirmed?).to be_falsey }
      end
    end
  end
end
