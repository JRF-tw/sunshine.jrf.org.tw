require "rails_helper"

describe Crontab::SubscribeStoryAfterJudgeNotifyContext do
  let!(:story_subscription_with_party) { FactoryGirl.create :story_subscription_with_party, :schedule_yesterday }

  describe "#perform" do
    context "send after judge notify" do
      subject { described_class.new(Date.today) }
      it { expect{ subject.perform }.to change_sidekiq_jobs_size_of(Sidekiq::Extensions::DelayedMailer) }
    end

    context "find after judge story" do
      subject { described_class.new(Date.today) }
      it { expect(subject.perform.first.schedules.last.date).to eq(Date.yesterday) }
    end
  end

end
