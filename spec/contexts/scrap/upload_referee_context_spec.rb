require 'rails_helper'

RSpec.describe Scrap::UploadRefereeContext, type: :model do
  let!(:original_data) { File.read("#{Rails.root}/spec/fixtures/scrap_data/ruling.html") }
  subject { described_class.new(original_data).perform(referee) }
  describe '#perform' do
    context 'rule' do
      let!(:referee) { create :rule }
      before { subject }
      it { expect(referee.file).to be_present }
      it { expect(referee.content_file).to be_present }
      it { expect(referee.roles_data).to be_present }
      it { expect(referee.reason).to be_present }
      it { expect(referee.judge_word).to be_present }
    end

    context 'verdict' do
      let!(:referee) { create :verdict }
      let!(:original_data) { File.read("#{Rails.root}/spec/fixtures/scrap_data/judgment.html") }
      before { subject }
      it { expect(referee.file).to be_present }
      it { expect(referee.content_file).to be_present }
      it { expect(referee.roles_data).to be_present }
      it { expect(referee.reason).to be_present }
      it { expect(referee.judge_word).to be_present }
      it { expect(referee.related_stories).to be_present }
    end
  end
end
