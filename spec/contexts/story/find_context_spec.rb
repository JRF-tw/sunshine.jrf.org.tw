require 'rails_helper'

describe Story::FindContext do
  let(:story) { create :story }
  let(:court) { story.court }
  let(:code) { court.code }
  let(:year) { story.year }
  let(:word_type) { story.word_type }
  let(:number) { story.number }
  subject { described_class.new(params) }

  describe '#perform' do
    context 'success' do
      let(:params) { { court_code: code, id: story.identity } }
      it { expect(subject.perform).to eq(story) }
    end

    context 'court not found' do
      let(:params) { { court_code: code + 'S', id: story.identity } }
      it { expect(subject.perform).to be_falsey }
    end

    context 'story not found' do
      let(:params) { { court_code: code, id: story.identity + '1' } }
      it { expect(subject.perform).to be_falsey }
    end
  end
end
