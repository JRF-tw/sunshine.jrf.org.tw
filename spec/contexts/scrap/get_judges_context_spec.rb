require 'rails_helper'

RSpec.describe Scrap::GetJudgesContext, type: :model do
  describe '#perform' do
    subject { described_class.new.perform }

    context 'notify_diff_info' do
      let!(:branches) { create_list :branch, 2 }

      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify).by(2) }
    end

    context 'notify daily report' do
      before { described_class.new.perform }
      subject { Scrap::NotifyDailyContext.new.perform }

      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end
end
