require "rails_helper"

describe Lawyer::VerdictScoreCheckJudgeContext do
  let!(:lawyer) { create :lawyer }
  let!(:court) { create :court }
  let!(:story) { create :story, :pronounced, :adjudged, court: court }
  let!(:judge) { create :judge, court: court }
  let!(:judge2) { create :judge }
  let!(:params) { { court_id: court.id, year: story.year, word_type: story.word_type, number: story.number, story_type: story.story_type, judge_name: judge.name } }

  describe "#perform" do
    subject { described_class.new(lawyer).perform(params) }

    context "success" do
      it { expect(subject).to be_truthy }
    end

    context "empty judge_name" do
      before { params[:judge_name] = "" }
      it { expect(subject).to be_falsey }
    end

    context "no judgment" do
      context "find judge in correct court" do
        before { params[:judge_name] = judge.name }
        it { expect(subject).to be_truthy }
      end

      context "can't found judge" do
        before { params[:judge_name] = "錯誤法官" }
        it { expect(subject).to be_falsey }
      end

      context "find judge in diff court" do
        before { params[:judge_name] = judge2.name }
        it { expect(subject).to be_falsey }
      end
    end

    context "has judgment" do
      let!(:verdict) { create :verdict, story: story, main_judge: judge, is_judgment: true }

      context "judge name correct" do
        before { params[:judge_name] = judge.name }
        it { expect(subject).to be_truthy }
      end

      context "judge name incorrect" do
        before { verdict.update_attributes(main_judge: judge2) }
        before { params[:judge_name] = judge.name }
        it { expect(subject).to be_falsey }
      end
    end
  end
end
