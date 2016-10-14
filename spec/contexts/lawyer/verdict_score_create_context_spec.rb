require "rails_helper"

describe Lawyer::VerdictScoreCreateContext do
  let!(:lawyer) { create :lawyer }
  let!(:court) { create :court }
  let!(:story) { create :story, :pronounced, :adjudged, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:judge2) { create :judge }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type, judge_name: judge.name, quality_score: 1, note: "xxxxx", appeal_judge: false } }

  describe "#perform" do
    subject { described_class.new(lawyer).perform(params) }

    context "success" do
      it { expect(subject).to be_truthy }
      it { expect(subject.verdict_rater).to eq(lawyer) }
      it { expect { subject }.to change { VerdictScore.count } }

      context "assign_attribute" do
        it { expect(subject.story).to eq(story) }
        it { expect(subject.judge).to eq(judge) }
      end
    end

    context "quality_score empty" do
      before { params[:quality_score] = "" }
      it { expect(subject).to be_falsey }
    end

    describe "#alert_story_by_lawyer_scored_count" do
      before { create_list :verdict_score, 2, story: story }
      before { create_list :schedule_score, 3, story: story }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end

    describe "#alert_lawyer_scored_story_count" do
      before { create_list :verdict_score, 2, verdict_rater: lawyer }
      before { create_list :schedule_score, 3, schedule_rater: lawyer }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end
end
