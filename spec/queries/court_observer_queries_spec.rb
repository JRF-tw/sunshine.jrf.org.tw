require "rails_helper"

RSpec.describe CourtObserverQueries do
  let!(:court_observer) { create :court_observer }
  let!(:story) { create :story }
  let!(:schedule_score) { create :schedule_score, schedule_rater: court_observer, story: story }
  let!(:query) { described_class.new(court_observer) }

  describe "#get_stories" do
    context "scored by schedule_score" do
      it { expect(query.get_stories.include?(story)).to be_truthy }
    end
  end

  describe "#get_schedule_score" do
    it { expect(query.get_schedule_score(story).include?(schedule_score)).to be_truthy }
  end

  describe "#pending_score_schedules" do
    before { create_list :schedule, 3, story: story }

    it { expect(query.pending_score_schedules(story).count).to eq(3) }
  end
end
