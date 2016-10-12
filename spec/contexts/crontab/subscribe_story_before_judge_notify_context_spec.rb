require "rails_helper"

describe Crontab::SubscribeStoryBeforeJudgeNotifyContext do
  let!(:story_subscription_with_party) { create :story_subscription_with_party, :schedule_tomorrow }

  describe "#perform" do
    context "send before judge notify" do
      subject { described_class.new(Time.zone.today) }
      it { expect { subject.perform }.to change_sidekiq_jobs_size_of(Sidekiq::Extensions::DelayedMailer) }
    end

    context "find before judge story" do
      subject { described_class.new(Time.zone.today) }
      it { expect(subject.perform.first.schedules.last.start_on).to eq(Time.zone.tomorrow) }
    end
  end
end
