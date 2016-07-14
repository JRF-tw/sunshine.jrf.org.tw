require "rails_helper"

describe Lawyer::ScheduleScoreCreateContext do
  let!(:lawyer) { FactoryGirl.create :lawyer }
  let!(:court) { FactoryGirl.create :court }
  let!(:story) { FactoryGirl.create :story, court: court }
  let!(:schedule) { FactoryGirl.create :schedule, story: story }
  let!(:judge) { FactoryGirl.create :judge, court: court }
  let!(:judge2) { FactoryGirl.create :judge }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false, judge_name: judge.name, command_score: 1, attitude_score: 1, note: "xxxxx", appeal_judge: false } }

  describe "#perform" do
    subject { described_class.new(lawyer).perform(params) }

    context "success" do
      it { expect(subject).to be_truthy }
      it { expect(subject.schedule_rater).to eq(lawyer) }
      it { expect { subject }.to change { ScheduleScore.count } }

      context "assign_attribute" do
        it { expect(subject.schedule).to eq(schedule) }
        it { expect(subject.judge).to eq(judge) }
      end
    end

    context "command_score empty" do
      before { params[:command_score] = "" }
      it { expect(subject).to be_falsey }
    end

    context "attitude_score empty" do
      before { params[:attitude_score] = "" }
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

    context "story over max scored count" do
      before { story.schedule_scored_count.value = 2 }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end

    context "lawyer over max scored count" do
      before { lawyer.schedule_scored_count.value = 2 }
      it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
    end
  end
end
