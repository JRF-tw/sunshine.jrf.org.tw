require 'rails_helper'

RSpec.describe Scrap::UploadRefereeFileContext, type: :model do
  let!(:original_data) { File.read("#{Rails.root}/spec/fixtures/scrap_data/rule.html") }
  subject { described_class.new(original_data).perform(referee) }
  describe '#perform' do
    context 'rule' do
      let!(:referee) { create :rule }
      before { subject }
      it { expect(referee.file).to be_present }
    end

    context 'verdict' do
      let!(:referee) { create :verdict }
      let!(:original_data) { File.read("#{Rails.root}/spec/fixtures/scrap_data/verdict.html") }
      before { subject }
      it { expect(referee.file).to be_present }
    end
  end
end
