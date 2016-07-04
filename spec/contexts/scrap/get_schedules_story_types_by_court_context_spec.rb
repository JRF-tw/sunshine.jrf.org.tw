require 'rails_helper'

RSpec.describe Scrap::GetSchedulesStoryTypesByCourtContext, type: :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH" }
  let!(:start_date) { Time.zone.today }
  let!(:end_date) { Time.zone.today }

  describe "#perform" do
    subject { described_class.new(court.code, start_date, end_date).perform }

    it { expect { subject }.to change_sidekiq_jobs_size_of(Scrap::GetSchedulesPagesByStoryTypeContext, :perform) }
  end
end
