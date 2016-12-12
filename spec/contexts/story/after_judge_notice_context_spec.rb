require 'rails_helper'

describe Story::AfterJudgeNoticeContext do
  let!(:story_subscription_with_party) { create :story_subscription_with_party }
  let!(:story) { Story.last }
  let!(:party) { Party.last }
  subject { described_class.new(story) }

  describe '#perform' do
    it { expect { subject.perform }.to change_sidekiq_jobs_size_of(Sidekiq::Extensions::DelayedMailer) }
  end

end
