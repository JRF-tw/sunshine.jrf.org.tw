require "rails_helper"

describe Lawyer::VerdictScoreUpdateContext do
  let!(:lawyer) { create :lawyer }
  let!(:verdict_score) { create :verdict_score, verdict_rater: lawyer }
  let(:context) { described_class.new(verdict_score) }

  describe "perform" do
    context "quality_score empty" do
      let!(:params) { { quality_score: "", note: "xxx", appeal_judge: false } }
      subject { context.perform(params) }

      it { expect(subject).to be_falsey }
    end

    context "success" do
      let!(:params) { { quality_score: 5, note: "xxx", appeal_judge: false } }
      subject { context.perform(params) }

      it { expect(subject).to be_truthy }
      it { expect { subject }.to change { verdict_score.reload.note } }
    end
  end
end
