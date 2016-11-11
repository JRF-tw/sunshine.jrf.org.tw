require 'rails_helper'

describe Party::SetPhoneContext do
  let!(:party) { create :party }
  subject { described_class.new(party, params) }

  describe '#perform' do
    context 'fail' do
      context 'check_sms_send_count' do
        let(:params) { { phone_form: { unconfirmed_phone: '0911222333' } } }
        before { party.sms_sent_count.value = 2 }
        before { subject.perform }
        it { expect(subject.has_error?).to be_truthy }
      end
    end

    context 'success' do
      let(:params) { { phone_form: { unconfirmed_phone: '0911222333' } } }
      it { expect { subject.perform }.to change { party.sms_sent_count.value } }
      it { expect { subject.perform }.to change_sidekiq_jobs_size_of(SmsService, :send_sms) }
      context 'assign_value' do
        before { subject.perform }
        it { expect(party.phone_varify_code.value).to be_present }
        it { expect(party.unconfirmed_phone).to eq('0911222333') }
      end

      context 'set_unconfirm' do
        before { subject.perform }
        it { expect(party.confirmed?).to be_falsey }
      end

      context 'reset_data' do
        context 'generate expire job' do
          it { expect { subject.perform }.to change { fetch_sidekiq_last_job(scheduled: true) } }
          it { expect { subject.perform }.to change { party.delete_phone_job_id.value } }
        end

        context 'replace exist expire job' do
          let(:params_1) { { phone_form: { unconfirmed_phone: '0933333333' } } }
          before { subject.perform }
          before { described_class.new(party, params_1).perform }
          it { expect(Sidekiq::ScheduledSet.new.size).to eq(1) }
        end
      end
    end
  end
end
