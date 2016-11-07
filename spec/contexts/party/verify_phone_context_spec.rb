require 'rails_helper'

describe Party::VerifyPhoneContext do

  describe '#perform' do
    let!(:party) { create :party }
    let(:params) { { phone_varify_code: '1111' } }
    before { party.phone_varify_code = '1111' }
    before { party.unconfirmed_phone = '0922888888' }
    subject { described_class.new(party, params) }

    context 'fails' do
      context 'record_retry_count' do
        let(:params) { { phone_varify_code: '2222' } }
        before { party.retry_verify_count.value = 1 }
        before { subject.perform }
        it { expect(party.retry_verify_count.value).to eq(2) }
      end

      context 'reset_data_out_retry_range' do
        let(:params) { { phone_varify_code: '2222' } }
        before { party.retry_verify_count.value = 2 }
        before { subject.perform }
        it { expect(party.retry_verify_count.value).to eq(0) }
        it { expect(party.unconfirmed_phone).to be_nil }
      end

    end

    context 'success' do
      it { expect { subject.perform }.to change { party.phone_number } }

      context 'assign_value' do
        before { subject.perform }

        it { expect(party.phone_number).to eq('0922888888') }
        it { expect(party.unconfirmed_phone.value).to be_nil }
      end

      context 'phone_confirmed?' do
        before { subject.perform }

        it { expect(party.phone_confirmed?).to be_truthy }
      end

      context 'reset_data' do
        before { subject.perform }

        it { expect(party.unconfirmed_phone).to be_nil }
        it { expect(party.phone_varify_code.value).to be_nil }
        it { expect(party.retry_verify_count.value).to eq(0) }
      end
    end
  end
end
