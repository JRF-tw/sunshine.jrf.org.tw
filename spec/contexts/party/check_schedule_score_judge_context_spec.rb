require "rails_helper"

describe Party::CheckScheduleScoreJudgeContext do
  let!(:party) { FactoryGirl.create :party }
  let!(:court) { FactoryGirl.create :court }
  let!(:story) { FactoryGirl.create :story, court: court }
  let!(:schedule) { FactoryGirl.create :schedule, story: story }
  let!(:judge) { FactoryGirl.create :judge, court: court }
  let!(:judge2) { FactoryGirl.create :judge }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, date: schedule.date, confirmed_realdate: false, judge_name: judge.name } }

  describe "#perform" do
    subject { described_class.new(party).perform(params) }

    context "success" do
      it { expect(subject).to be_truthy }
    end

    context "judge_name empty" do
      before { params[:judge_name] = "" }
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
  end
end
