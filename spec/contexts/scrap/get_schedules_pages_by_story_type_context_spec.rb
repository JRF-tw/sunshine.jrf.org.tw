require "rails_helper"

RSpec.describe Scrap::GetSchedulesPagesByStoryTypeContext, type: :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH" }
  let!(:story_type) { "V" }
  let!(:start_date) { Time.zone.today }
  let!(:end_date) { Time.zone.today }

  describe "#perform" do
    subject { described_class.new(court.code, story_type, start_date, end_date).perform }

    it { expect { subject }.to change_sidekiq_jobs_size_of(Scrap::ParseSchedulesContext, :perform) }
  end
end
