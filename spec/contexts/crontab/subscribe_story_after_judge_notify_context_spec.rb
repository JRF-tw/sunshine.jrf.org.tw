require 'rails_helper'

describe Crontab::SubscribeStoryAfterJudgeNotifyContext do
  let!(:story_subscription_with_party) { create :story_subscription_with_party, :schedule_today }

  describe '#perform' do
    context 'send after judge notify' do
      subject { described_class.new(Time.zone.today) }
      it { expect { subject.perform }.to change_sidekiq_jobs_size_of(Sidekiq::Extensions::DelayedMailer) }
    end

    context 'find after judge story' do
      subject { described_class.new(Time.zone.today) }
      it { expect(subject.perform.first.schedules.last.start_on).to eq(Time.zone.today) }
    end
  end

end
