require "rails_helper"

describe Crontab::SubscribeStoryNotifyContext do
  let!(:story_subscription_with_party) { FactoryGirl.create :story_subscription_with_party }

  describe "#perform" do
    context "send open court notify" do
      subject { described_class.new(Date.yesterday) }
      it { expect{ subject.perform }.to change_sidekiq_jobs_size_of(Sidekiq::Extensions::DelayedMailer) }
    end

    context "send close court notify" do
      subject { described_class.new(Date.tomorrow) }
      it { expect{ subject.perform }.to change_sidekiq_jobs_size_of(Sidekiq::Extensions::DelayedMailer) }
    end
  end

end



