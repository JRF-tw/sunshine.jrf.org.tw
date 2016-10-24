require 'rails_helper'

RSpec.describe Scrap::GetVerdictsContext, type: :model do
  let!(:court) { create :court, code: 'TPH', scrap_name: '臺灣高等法院' }

  describe '#perform' do
    subject { described_class.new.perform }
    it { expect { subject }.to change_sidekiq_jobs_size_of(Scrap::GetVerdictsByCourtContext, :perform) }

    context 'notify daily report' do
      before { described_class.new.perform }
      subject { Scrap::NotifyDailyContext.new.perform }

      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end
end
