require 'rails_helper'

describe Party::VerdictScoreUpdateContext do
  let!(:party) { create :party }
  let!(:verdict_score) { create :verdict_score, verdict_rater: party }
  let(:context) { described_class.new(verdict_score) }

  describe 'perform' do
    context 'quality_scores score empty' do
      let!(:params) { attributes_for(:verdict_score_for_update_no_quality_params) }
      subject { context.perform(params) }

      it { expect(subject).to be_falsey }
    end

    context 'success' do
      let!(:params) { attributes_for(:verdict_score_for_update_params) }
      subject { context.perform(params) }

      it { expect(subject).to be_truthy }
      it { expect { subject }.to change { verdict_score.reload.note } }
    end
  end
end
