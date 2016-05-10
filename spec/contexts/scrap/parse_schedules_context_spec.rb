require 'rails_helper'

RSpec.describe Scrap::ParseSchedulesContext, :type => :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH" }
  let!(:info) { { court_code: court.code, story_type: "V", page_total: 17 } }
  let!(:current_page) { "1" }
  let!(:start_date_format) { "1050510" }
  let!(:end_date_format) { "1050510" }


  describe "#perform" do
    subject{ described_class.new(info, current_page, start_date_format, end_date_format).perform }
    it { expect{ subject }.to change_sidekiq_jobs_size_of(Scrap::ImportScheduleContext, :perform) }
  end
end
