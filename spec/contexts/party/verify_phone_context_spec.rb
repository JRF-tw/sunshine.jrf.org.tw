require 'rails_helper'

describe Party::VerifyPhoneContext do

  describe '#perform' do
    let!(:party) { create :party, unconfirmed_phone: '0922222222' }
    let(:params) { { phone_varify_code: '1111' } }
    before { party.phone_varify_code = '1111' }
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
        it { expect(party.phone_number).to eq('0922222222') }
        it { expect(party.unconfirmed_phone).to be_nil }
      end

      context 'phone_confirmed?' do
        before { subject.perform }

        it { expect(party.phone_confirmed?).to be_truthy }
      end

      context 'reset_data' do
        context 'success' do
          before { subject.perform }
          it { expect(Sidekiq::ScheduledSet.new.size).to eq(0) }
          it { expect(party.delete_phone_job_id.value).to be_nil }
          it { expect(party.unconfirmed_phone).to be_nil }
          it { expect(party.phone_varify_code.value).to be_nil }
          it { expect(party.retry_verify_count.value).to eq(0) }
        end

        context 'clean Sidekiq job if exist' do
          before { party.delete_phone_job_id = party.delay_until(1.hour.from_now).update_columns(unconfirmed_phone: nil) }
          it { expect { subject.perform }.to change { Sidekiq::ScheduledSet.new.size }.by(-1) }
        end
      end
    end
  end
end
