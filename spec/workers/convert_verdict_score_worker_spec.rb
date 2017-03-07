require 'rails_helper'

RSpec.describe ConvertVerdictScoreWorker, type: :worker do
  describe '#perform' do
    context 'expired_story exist' do
      let!(:expired_story) { create :story, pronounce_date: Time.zone.today - 4.months }
      subject { described_class.new }
      it { expect { subject.perform }.to change_sidekiq_jobs_size_of(Sidekiq::Extensions::DelayedClass) }
    end

    context 'expired_story not exist' do
      let!(:story) { create :story, pronounce_date: Time.zone.today }
      subject { described_class.new }
      it { expect { subject.perform }.not_to change_sidekiq_jobs_size_of(Sidekiq::Extensions::DelayedClass) }
    end
  end
end
