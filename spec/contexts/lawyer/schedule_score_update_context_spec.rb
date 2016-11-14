require 'rails_helper'

describe Lawyer::ScheduleScoreUpdateContext do
  let!(:party) { create :party }
  let!(:schedule_score) { create :schedule_score, schedule_rater: party }
  let(:context) { described_class.new(schedule_score) }

  describe 'perform' do
    context 'command_score empty' do
      let!(:params) { { score_1_1: 1, score_1_2: 1, score_1_3: 1, note: 'xxx', appeal_judge: false } }
      subject { context.perform(params) }

      it { expect(subject).to be_falsey }
    end

    context 'attitude_score empty' do
      let!(:params) { { score_2_1: 1, score_2_2: 1, score_2_3: 1, score_2_4: 1, score_2_5: 1, note: 'xxx', appeal_judge: false } }
      subject { context.perform(params) }

      it { expect(subject).to be_falsey }
    end

    context 'success' do
      let!(:params) { { score_1_1: 1, score_1_2: 1, score_1_3: 1, score_2_1: 1, score_2_2: 1, score_2_3: 1, score_2_4: 1, score_2_5: 1, note: 'xxx', appeal_judge: false } }
      subject { context.perform(params) }

      it { expect(subject).to be_truthy }
      it { expect { subject }.to change { schedule_score.reload.note } }
    end
  end
end
