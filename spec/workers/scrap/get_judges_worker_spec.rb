require "rails_helper"

RSpec.describe Scrap::GetJudgesWorker, type: :worker do
  subject { described_class.new.perform }

  it { expect { subject }.to change_sidekiq_jobs_size_of(Scrap::GetJudgesContext, :perform) }
end
