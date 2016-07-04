require "rails_helper"

RSpec.describe Scrap::ParseVerdictContext, type: :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH", scrap_name: "臺灣高等法院" }
  let!(:scrap_id) { "1" }
  let!(:type) { "V" }
  let!(:start_date) { Time.zone.today.strftime("%Y%m%d") }
  let!(:end_date) { Time.zone.today.strftime("%Y%m%d") }

  describe "#perform" do
    subject { described_class.new(court, scrap_id, type, start_date, end_date).perform }
    it { expect { subject }.to change_sidekiq_jobs_size_of(Scrap::ImportVerdictContext, :perform) }
  end
end
