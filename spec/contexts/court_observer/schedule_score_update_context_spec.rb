require 'rails_helper'

describe CourtObserver::ScheduleScoreUpdateContext do
  let!(:court_observer) { create :court_observer }
  let!(:schedule_score) { create :schedule_score, schedule_rater: court_observer }
  let(:context) { described_class.new(schedule_score) }

  describe 'perform' do
    context 'rating score empty' do
      let!(:params) { { rating_score: '', note: 'xxx', appeal_judge: false } }
      subject { context.perform(params) }

      it { expect(subject).to be_falsey }
    end

    context 'success' do
      let!(:params) { { rating_score: 5, note: 'xxx', appeal_judge: false } }
      subject { context.perform(params) }

      it { expect(subject).to be_truthy }
      it { expect { subject }.to change { schedule_score.reload.note } }
    end
  end
end
