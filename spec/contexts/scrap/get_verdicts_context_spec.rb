require 'rails_helper'

RSpec.describe Scrap::GetVerdictsContext, :type => :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH", full_name: "臺灣高等法院" }

  describe "#perform_all" do
    subject{ described_class.perform_all }
    it { expect{ subject }.to change_sidekiq_jobs_size_of(Scrap::GetVerdictsContext, :perform) }
  end

  describe "#perform" do
    let!(:import_data) { Mechanize.new.get(Scrap::GetVerdictsContext::VERDICT_URI) }
    subject{ described_class.perform(import_data, court) }
    it { expect{ subject }.to change{ court.stories.count } }
    it { expect{ subject }.to change{ Verdict.count } }
  end
end
