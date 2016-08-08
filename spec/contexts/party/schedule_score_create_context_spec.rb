require "rails_helper"

describe Party::ScheduleScoreCreateContext do
  let!(:party) { create :party }
  let!(:court) { create :court }
  let!(:story) { create :story, court: court }
  let!(:schedule) { create :schedule, story: story }
  let!(:judge) { create :judge, court: court }
  let!(:judge2) { create :judge }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false, judge_name: judge.name, rating_score: 1, note: "xxxxx", appeal_judge: false } }

  describe "#perform" do
    subject { described_class.new(party).perform(params) }

    context "success" do
      it { expect(subject).to be_truthy }
      it { expect(subject.schedule_rater).to eq(party) }
      it { expect { subject }.to change { ScheduleScore.count } }

      context "assign_attribute" do
        it { expect(subject.schedule).to eq(schedule) }
        it { expect(subject.judge).to eq(judge) }
      end
    end

    context "rating_score empty" do
      before { params[:rating_score] = "" }
      it { expect(subject).to be_falsey }
    end

    context "can't found judge" do
      before { params[:judge_name] = "錯誤法官" }
      it { expect(subject).to be_falsey }
    end

    context "judge not in in court" do
      before { params[:judge_name] = judge2.name }
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
