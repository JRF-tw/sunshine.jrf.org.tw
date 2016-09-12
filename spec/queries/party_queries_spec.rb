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
    it { expect(query.get_verdict_score(story)).to eq(verdict_score) }
  end

  describe "#get_relate_stories" do
    let!(:story_relation) { create :story_relation, people: party, story: story }
    it { expect(query.get_relate_stories.include?(story_relation.story)).to be_truthy }
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

    context "story already scored" do
      let!(:verdict_score) { create :verdict_score, verdict_rater: party, story: story }
      it { expect(query.pending_score_verdict(story)).to be_nil }
    end
  end

  describe "#get_scores_array" do
    context "have schedule_scores" do
      let!(:schedule_score) { create :schedule_score, schedule_rater: party, story: story }
      let(:date) { schedule_score.schedule.start_on }
      let(:court_code) { story.court.code }

      it { expect(query.get_scores_array(story).first.is_a?(Hash)).to be_truthy }
      it { expect(query.get_scores_array(story).first["date"]).to eq(date) }
      it { expect(query.get_scores_array(story).first["court_code"]).to eq(court_code) }
      it { expect(query.get_scores_array(story).first["schedule_score"]).to be_truthy }
    end

    context "get schedule_scores date if without schedule" do
      let!(:schedule_score) { create :schedule_score, :without_schedule, schedule_rater: party, story: story, data: { start_on: "2016-09-01" } }

      it { expect(query.get_scores_array(story).first.is_a?(Hash)).to be_truthy }
      it { expect(query.get_scores_array(story).first["date"]).to eq("2016-09-01") }
    end

    context "have verdict_scores" do
      let!(:verdict_score) { create :verdict_score, verdict_rater: party, story: story }
      let(:date) { verdict_score.story.adjudge_date }
      let(:court_code) { story.court.code }

      it { expect(query.get_scores_array(story).first.is_a?(Hash)).to be_truthy }
      it { expect(query.get_scores_array(story).first["date"]).to eq(date) }
      it { expect(query.get_scores_array(story).first["court_code"]).to eq(court_code) }
      it { expect(query.get_scores_array(story).first["verdict_score"]).to be_truthy }
    end

    context "sorted by date" do
      let!(:yesterday_judge_story) { create(:story, :adjudged_yesterday) }
      let!(:verdict_score) { create :verdict_score, verdict_rater: party, story: yesterday_judge_story }
      let!(:schedule_score) { create :schedule_score, schedule_rater: party, story: yesterday_judge_story }

      it { expect(query.get_scores_array(yesterday_judge_story, sort_by: "date").first["date"]).to eq(verdict_score.story.adjudge_date) }
    end
  end
end
