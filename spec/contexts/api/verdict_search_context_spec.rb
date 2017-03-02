require 'rails_helper'

describe Api::VerdictSearchContext do
  let!(:verdict) { create :verdict, :with_file }
  let(:story) { verdict.story }
  let(:court) { verdict.story.court }
  let(:code) { court.code }
  let(:year) { story.year }
  let(:word_type) { story.word_type }
  let(:number) { story.number }
  subject { described_class.new(params) }

  describe '#perform' do
    context 'success' do
      let(:params) { "#{code}-#{year}-#{word_type}-#{number}" }
      it { expect(subject.perform).to eq([verdict]) }
    end

    context 'court not found' do
      let(:params) { "HHH-#{year}-#{word_type}-#{number}" }
      it { expect(subject.perform).to be_falsey }
    end

    context 'story not found' do
      let(:params) { "#{code}-#{year + 1}-#{word_type}-#{number}" }
      it { expect(subject.perform).to be_falsey }
    end

    context 'verdict not found' do
      let(:params) { "#{code}-#{year}-#{word_type}-#{number}" }
      before { Verdict.destroy_all }
      it { expect(subject.perform).to be_falsey }
    end
  end

end
