require "rails_helper"

RSpec.describe Scrap::GetCourtsWorker, type: :worker do
  subject { described_class.new.perform }

  it { expect { subject }.to change_sidekiq_jobs_size_of(Scrap::GetCourtsContext, :perform) }
end
