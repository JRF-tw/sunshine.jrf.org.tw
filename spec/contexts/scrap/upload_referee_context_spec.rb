require 'rails_helper'

RSpec.describe Scrap::UploadRefereeContext, type: :model do
  let!(:original_data) { File.read("#{Rails.root}/spec/fixtures/scrap_data/ruling_content.html") }
  let!(:verdict) { create :verdict }
  subject { described_class.new(original_data).perform(verdict) }

  describe '#perform' do
    before { subject }
    it { expect(verdict.file).to be_present }
    it { expect(verdict.content_file).to be_present }
    it { expect(verdict.crawl_data).to be_present }
  end
end
