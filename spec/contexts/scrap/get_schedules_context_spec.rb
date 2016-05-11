require 'rails_helper'

RSpec.describe Scrap::GetSchedulesContext, :type => :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH" }

  describe "#perform" do
    subject{ described_class.new.perform }

    it { expect{ subject }.to change_sidekiq_jobs_size_of(Scrap::ImportScheduleContext, :perform) }
  end
end
