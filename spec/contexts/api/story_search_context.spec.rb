require 'rails_helper'

describe Api::StorySearchContext do
  let!(:story1) { create :story, word_type: '下難', judges_names: ['宇智波佐助'], lawyer_names: ['旗木卡卡西'] }
  let!(:story2) { create :story, word_type: '上易', judges_names: ['旋渦鳴人', '宇智波佐助'], adjudge_date: Time.zone.today - 5.days }
  let!(:story3) { create :story, word_type: '中庸', adjudge_date: Time.zone.today - 3.days }
  subject { described_class.new(params).perform }

  describe '#perform' do
    context 'search court' do
      let!(:params) { { court_code: story1.court.code } }
      it { expect(subject).to eq([story1]) }
    end

    context 'search word & number & year & type' do
      let!(:params) {
        {
          year: story2.year,
          word: story2.word_type,
          number: story2.number,
          story_type: story2.story_type
        } }
      it { expect(subject).to eq([story2]) }
    end

    context 'search lawyer_names' do
      let!(:params) { { lawyer_names_cont: '卡卡西' } }
      it { expect(subject).to eq([story1]) }
    end

    context 'search judges_names' do
      let!(:params) { { judge_names_cont: '宇智波' } }
      it { expect(subject).to eq([story2, story1]) }
    end

    context 'search adjudge_date' do
      context 'only adjudge_date_gteq' do
        let!(:params) { { adjudge_date_gteq: story2.adjudge_date.to_s } }
        it { expect(subject).to eq([story3, story2]) }
      end

      context 'date_gteq with date_lteq' do
        let!(:params) { { adjudge_date_gteq: story2.adjudge_date.to_s, adjudge_date_lteq: (story2.adjudge_date + 1.day).to_s } }
        it { expect(subject).to eq([story2]) }
      end
    end
  end
end
