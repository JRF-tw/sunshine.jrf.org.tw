require "rails_helper"

describe Party::VerdictScoreCreateContext do
  let!(:party) { create :party }
  let!(:court) { create :court }
  let!(:story) { create :story, :pronounced, :adjudged, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:judge2) { create :judge }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, judge_name: judge.name, rating_score: 1, note: "xxxxx", appeal_judge: false } }

  describe "#perform" do
    subject { described_class.new(party).perform(params) }

    context "success" do
      it { expect(subject).to be_truthy }
      it { expect(subject.verdict_rater).to eq(party) }
      it { expect { subject }.to change { VerdictScore.count } }

      context "assign_attribute" do
        it { expect(subject.story).to eq(story) }
        it { expect(subject.judge).to eq(judge) }
      end
    end

    context "rating_score empty" do
      before { params[:rating_score] = "" }
      it { expect(subject).to be_falsey }
    end

    context "story over max scored count" do
      before { story.verdict_scored_count.value = 2 }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end

    context "party over max scored count" do
      before { party.verdict_scored_count.value = 2 }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end
end
