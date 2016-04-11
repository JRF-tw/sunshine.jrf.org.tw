require 'rails_helper'

RSpec.describe Scrap::ImportScheduleContext, :type => :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH" }

  describe ".perform_all" do
    subject{ described_class.perform_all }
    it { expect{ subject }.to change_sidekiq_jobs_size_of(Scrap::ImportScheduleContext, :perform) }
  end

  describe ".perform" do
    xit "just random sleep time & do #perform"
  end

  describe "#perform" do
    let!(:info_data) { { court_code: court.code, story_type: "V" } }
    let!(:current_page) { 1 }
    subject{ described_class.new(info_data, current_page).perform }

    it { expect{ subject }.to change{ court.schedules.count } }
    it { expect{ subject }.to change{ court.stories.count } }
  end
end
