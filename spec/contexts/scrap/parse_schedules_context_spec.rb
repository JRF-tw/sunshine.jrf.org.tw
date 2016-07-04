require 'rails_helper'

RSpec.describe Scrap::ParseSchedulesContext, type: :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH" }
  let!(:story_type) { "V" }
  let!(:current_page) { "1" }
  let!(:page_total) { 17 }
  let!(:start_date_format) { "1050510" }
  let!(:end_date_format) { "1050510" }

  describe "#perform" do
    subject { described_class.new(court.code, story_type, current_page, page_total, start_date_format, end_date_format).perform }

    it { expect { subject }.to change_sidekiq_jobs_size_of(Scrap::ImportScheduleContext, :perform) }
  end
end
