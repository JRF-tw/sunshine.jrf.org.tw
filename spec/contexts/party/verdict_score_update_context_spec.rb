require 'rails_helper'

describe Party::VerdictScoreUpdateContext do
  let!(:party) { create :party }
  let!(:verdict_score) { create :verdict_score, verdict_rater: party }
  let(:context) { described_class.new(verdict_score) }

  describe 'perform' do
    context 'rating score empty' do
      let!(:params) { { rating_score: '', note: 'xxx', appeal_judge: false } }
      subject { context.perform(params) }

      it { expect(subject).to be_falsey }
    end

    context 'success' do
      let!(:params) { { rating_score: 5, note: 'xxx', appeal_judge: false } }
      subject { context.perform(params) }

      it { expect(subject).to be_truthy }
      it { expect { subject }.to change { verdict_score.reload.note } }
    end
  end
end
