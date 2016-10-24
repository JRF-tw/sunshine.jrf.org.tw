require 'rails_helper'

describe SlackService do

  describe '#notify_async' do
    context 'success async to sidekiq' do
      let!(:message) { 'test' }
      subject { described_class.notify_async(message) }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end
end
