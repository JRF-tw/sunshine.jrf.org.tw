require 'rails_helper'

describe Api::StoryFindContext do
  let(:story) { create :story }
  let(:court) { story.court }
  let(:code) { court.code }
  let(:year) { story.year }
  let(:word_type) { story.word_type }
  let(:number) { story.number }
  subject { described_class.new(params) }

  describe '#perform' do
    context 'success' do
      let(:params) { { court_code: code, id: "#{year}-#{word_type}-#{number}" } }
      it { expect(subject.perform).to eq(story) }
    end

    context 'court not found' do
      let(:params) { { court_code: code + 'S', id: "#{year}-#{word_type}-#{number}" } }
      it { expect(subject.perform).to be_falsey }
    end

    context 'story not found' do
      let(:params) { { court_code: code, id: "#{year}-無此字號-#{number}" } }
      it { expect(subject.perform).to be_falsey }
    end
  end
end
