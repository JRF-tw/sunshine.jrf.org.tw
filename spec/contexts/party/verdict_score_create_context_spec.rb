require "rails_helper"

describe Party::VerdictScoreCreateContext do
  let!(:party) { create :party }
  let!(:court) { create :court }
  let!(:story) { create :story, :pronounced, :adjudged, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:judge2) { create :judge }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type, rating_score: 1, note: "xxxxx", appeal_judge: false } }

  describe "#perform" do
    subject { described_class.new(party).perform(params) }

    context "success" do
      it { expect(subject).to be_truthy }
      it { expect(subject.verdict_rater).to eq(party) }
      it { expect { subject }.to change { VerdictScore.count } }

      context "assign_attribute" do
        it { expect(subject.story).to eq(story) }
      end
    end

    context "rating_score empty" do
      before { params[:rating_score] = "" }
      it { expect(subject).to be_falsey }
    end

    describe "#alert_story_by_party_scored_count" do
      before { create_list :verdict_score, 1, :by_party, story: story }
      before { create_list :schedule_score, 2, :by_party, story: story }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end

    describe "#alert_party_scored_story_count" do
      before { create_list :verdict_score, 1, verdict_rater: party }
      before { create_list :schedule_score, 1, schedule_rater: party }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end
end
