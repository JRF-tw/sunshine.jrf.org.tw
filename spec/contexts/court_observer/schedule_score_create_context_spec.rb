require 'rails_helper'

describe CourtObserver::ScheduleScoreCreateContext do
  let!(:court_observer) { create :court_observer }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:judge) { create :judge, court: court }
  let!(:judge2) { create :judge }
  let!(:params) { attributes_for(:schedule_score_for_params, court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type, judge_name: judge.name) }

  describe '#perform' do
    subject { described_class.new(court_observer).perform(params) }

    context 'success' do
      it { expect(subject).to be_truthy }
      it { expect(subject.schedule_rater).to eq(court_observer) }
      it { expect { subject }.to change { ScheduleScore.count } }

      context 'assign_attribute' do
        it { expect(subject.schedule).to eq(schedule) }
        it { expect(subject.judge).to eq(judge) }
      end
    end

    context 'rating_score empty' do
      before { params[:score_1_1] = '' }
      it { expect(subject).to be_falsey }
    end

    context "can't found judge" do
      before { params[:judge_name] = '錯誤法官' }
      it { expect(subject).to be_falsey }
    end

    context 'judge not in in court' do
      before { params[:judge_name] = judge2.name }
      it { expect(subject).to be_falsey }
    end
  end
end
