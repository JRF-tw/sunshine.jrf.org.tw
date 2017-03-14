require 'rails_helper'

RSpec.describe Scrap::UploadRefereeContext, type: :model do
  let!(:original_data) { File.read("#{Rails.root}/spec/fixtures/scrap_data/ruling.html") }
  let!(:rule) { create :rule }
  subject { described_class.new(original_data).perform(rule) }

  describe '#perform' do
    before { subject }
    it { expect(rule.file).to be_present }
    it { expect(rule.content_file).to be_present }
    it { expect(rule.crawl_data).to be_present }
  end
end
