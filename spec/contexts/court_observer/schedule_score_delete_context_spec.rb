require 'rails_helper'

describe CourtObserver::ScheduleScoreDeleteContext do
  let!(:court_observer) { create :court_observer }
  let!(:schedule_score) { create :schedule_score, schedule_rater: court_observer }
  let(:context) { described_class.new(schedule_score) }

  describe '#perform' do
    context 'success' do
      subject! { described_class.new(schedule_score) }
      it { expect { subject.perform }.to change { ScheduleScore.count }.by(-1) }
    end
  end

end
