require 'rails_helper'

RSpec.describe Scrap::GetSupremeCourtJudgesContext, type: :model do
  describe '#perform' do
    subject { described_class.new.perform }

    context 'notify_diff_info' do
      let!(:court) { create :court, full_name: '最高法院', name: '最高院', code: 'TPS' }
      let!(:branches) { create_list :branch, 2, court: court }

      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify).by(2) }
    end

    context 'create TPS if not exist' do
      it { expect { subject }.to change { Court.count }.by(1) }
    end
  end
end
