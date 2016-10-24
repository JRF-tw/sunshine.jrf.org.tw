require 'rails_helper'

RSpec.describe Scrap::GetSchedulesContext, type: :model do
  let!(:court) { create :court, code: 'TPH' }

  describe '#perform' do
    subject { described_class.new.perform }

    it { expect { subject }.to change_sidekiq_jobs_size_of(Scrap::GetSchedulesStoryTypesByCourtContext, :perform) }

    context 'notify daily report' do
      before { described_class.new.perform }
      subject { Scrap::NotifyDailyContext.new.perform }

      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end
end
