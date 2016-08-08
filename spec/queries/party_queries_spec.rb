require "rails_helper"

RSpec.describe PartyQueries do
  let!(:party) { create :party }
  let!(:story) { create :story }
  let!(:query) { described_class.new(party) }

  describe "#get_stories" do
    context "scored by story_relation" do
      let!(:story_relation) { create :story_relation, people: party, story: story }
      it { expect(query.get_stories.include?(story)).to be_truthy }
    end

    context "scored by schedule_score" do
      let!(:schedule_score) { create :schedule_score, schedule_rater: party, story: story }
      it { expect(query.get_stories.include?(story)).to be_truthy }
    end

    context "scored by verdict_score" do
      let!(:verdict_score) { create :verdict_score, verdict_rater: party, story: story }
      it { expect(query.get_stories.include?(story)).to be_truthy }
    end
  end

  describe "#get_schedule_score" do
    let!(:schedule_score) { create :schedule_score, schedule_rater: party, story: story }
    it { expect(query.get_schedule_score(story).include?(schedule_score)).to be_truthy }
  end

  describe "#get_verdict_score" do
    let!(:verdict_score) { create :verdict_score, verdict_rater: party, story: story }
    it { expect(query.get_verdict_score(story).include?(verdict_score)).to be_truthy }
  end

  describe "#pending_score_schedules" do
    before { create_list :schedule, 3, story: story }

    it { expect(query.pending_score_schedules(story).count).to eq(3) }
  end

  describe "#pending_score_verdict" do
    context "story isn't get judgment_verdict" do
      it { expect(query.pending_score_schedules(story).count).to eq(0) }
    end

    context "story get judgment_verdict" do
      let!(:verdict) { create :verdict, story: story, is_judgment: true }
      it { expect(query.pending_score_verdict(story)).to eq(verdict) }
    end
  end
end
