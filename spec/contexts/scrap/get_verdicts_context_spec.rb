require 'rails_helper'

RSpec.describe Scrap::GetVerdictsContext, :type => :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH", scrap_name: "臺灣高等法院" }

  describe "#perform" do
    subject{ described_class.new.perform }
    it { expect{ subject }.to change_sidekiq_jobs_size_of(Scrap::ImportVerdictContext, :perform) }
  end
end
