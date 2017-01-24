require 'rails_helper'

RSpec.describe Scrap::UploadVerdictContext, type: :model do
  let!(:origin_data) { '全文' }
  let!(:content) { '測試上傳內容' }
  let!(:verdict) { create :verdict }
  subject { described_class.new(origin_data, content).perform(verdict) }

  describe '#perform' do
    before { subject }
    it { expect(verdict.file).to be_present }
    it { expect(verdict.content).to be_present }
  end
end
