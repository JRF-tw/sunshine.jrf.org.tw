require 'rails_helper'

RSpec.describe Scrap::GetCourtsContext, type: :model do

  describe "#perform" do
    context "success" do
      subject { described_class.new.perform }
      it { expect { subject }.to change_sidekiq_jobs_size_of(Scrap::ImportCourtContext, :perform) }
    end

    context "check_db_data_and_notify" do
      # see spec/features/courts_update_from_scrap_spec.rb:37
    end

    context "notify daily report" do
      before { described_class.new.perform }
      subject { Scrap::NotifyDailyContext.new.perform }

      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end
end
