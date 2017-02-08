require 'rails_helper'

RSpec.describe Scrap::UploadVerdictContext, type: :model do
  let!(:origin_data) { Mechanize.new.get(Scrap::ParseVerdictContext::VERDICT_URI).body.force_encoding('UTF-8') }
  let!(:verdict) { create :verdict }
  subject { described_class.new(origin_data).perform(verdict) }

  describe '#perform' do
    before { subject }
    it { expect(verdict.file).to be_present }
    it { expect(verdict.content_file).to be_present }
  end
end
