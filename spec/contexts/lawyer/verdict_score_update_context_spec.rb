require 'rails_helper'

describe Lawyer::VerdictScoreUpdateContext do
  let!(:lawyer) { create :lawyer }
  let!(:verdict_score) { create :verdict_score, verdict_rater: lawyer }
  let(:context) { described_class.new(verdict_score) }

  describe 'perform' do
    context 'quality_score empty' do
      let!(:params) { { score_3_1: '', note: 'xxx', appeal_judge: false } }
      subject { context.perform(params) }

      it { expect(subject).to be_falsey }
    end

    context 'success' do
      let!(:params) { { score_3_1: 5, score_3_2_1: 5, score_3_2_2: 5, score_3_2_3: 5, score_3_2_4: 5, score_3_2_5: 5, score_3_2_6: 5, note: 'xxx', appeal_judge: false } }
      subject { context.perform(params) }

      it { expect(subject).to be_truthy }
      it { expect { subject }.to change { verdict_score.reload.note } }
    end
  end
end
