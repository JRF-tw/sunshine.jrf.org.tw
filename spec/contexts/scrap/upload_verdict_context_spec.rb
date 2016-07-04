require "rails_helper"

RSpec.describe Scrap::UploadVerdictContext, type: :model do
  let!(:content) { "測試上傳內容" }
  let!(:verdict) { FactoryGirl.create :verdict }
  subject { described_class.new(content).perform(verdict) }

  describe "#perform" do
    before { subject }
    it { expect(verdict.file).to be_present }
  end
end
