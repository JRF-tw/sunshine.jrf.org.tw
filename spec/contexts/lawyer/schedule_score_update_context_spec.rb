require 'rails_helper'

describe Lawyer::ScheduleScoreUpdateContext do
  let!(:party) { create :party }
  let!(:schedule_score) { create :schedule_score, schedule_rater: party }
  let(:context) { described_class.new(schedule_score) }

  describe 'perform' do
    context 'command_score empty' do
      let!(:params) { attributes_for(:schedule_score_for_update_no_command_params) }
      subject { context.perform(params) }

      it { expect(subject).to be_falsey }
    end

    context 'attitude_score empty' do
      let!(:params) { attributes_for(:schedule_score_for_update_no_attitute_params) }
      subject { context.perform(params) }

      it { expect(subject).to be_falsey }
    end

    context 'success' do
      let!(:params) { attributes_for(:schedule_score_for_update_params) }
      subject { context.perform(params) }

      it { expect(subject).to be_truthy }
      it { expect { subject }.to change { schedule_score.reload.note } }
    end
  end
end
