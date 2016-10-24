require 'rails_helper'

RSpec.describe CourtObserverQueries do
  let!(:court_observer) { create :court_observer }
  let!(:story) { create :story }
  let!(:schedule_score) { create :schedule_score, schedule_rater: court_observer, story: story }
  let!(:query) { described_class.new(court_observer) }

  describe '#get_stories' do
    context 'scored by schedule_score' do
      it { expect(query.get_stories.include?(story)).to be_truthy }
    end
  end

  describe '#get_schedule_scores_array' do
    context 'have schedule_scores' do
      let!(:schedule_score) { create :schedule_score, :with_start_on, schedule_rater: court_observer, story: story }
      let(:date) { schedule_score.schedule.start_on }
      let(:court_code) { story.court.code }

      it { expect(query.get_schedule_scores_array(story).first.is_a?(Hash)).to be_truthy }
      it { expect(query.get_schedule_scores_array(story).first['date']).to eq(date.to_s) }
      it { expect(query.get_schedule_scores_array(story).first['court_code']).to eq(court_code) }
      it { expect(query.get_schedule_scores_array(story).first['schedule_score']).to be_truthy }
    end

    context 'get schedule_scores date if without schedule' do
      let!(:schedule_score) { create :schedule_score, :without_schedule, schedule_rater: court_observer, story: story, data: { start_on: '2016-09-01' } }

      it { expect(query.get_schedule_scores_array(story).first.is_a?(Hash)).to be_truthy }
      it { expect(query.get_schedule_scores_array(story).first['date']).to eq('2016-09-01') }
    end
  end

  describe '#pending_score_schedules' do
    before { create_list :schedule, 3, story: story }

    it { expect(query.pending_score_schedules(story).count).to eq(3) }
  end
end
