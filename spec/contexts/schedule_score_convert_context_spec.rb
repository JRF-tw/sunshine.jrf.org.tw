require 'rails_helper'

describe ScheduleScoreConvertContext do
  let!(:story) { create :story, :pronounced }
  let(:schedule_score) { create :schedule_score_for_params, judge: judge_A, story: story, schedule_rater: role }
  let!(:judge_A) { create :judge }
  subject { described_class.new(schedule_score).perform }

  context '#perform' do
    context 'court_observer' do
      let!(:role) { create :court_observer }

      context 'verdict with judges' do
        let!(:verdict) { create :verdict_for_convert_valid_score, story: story, judges_names: [judge_A.name] }
        it { expect { subject }.to change { ValidScore.count } }
      end
    end

    context 'party' do
      let!(:role) { create :party, :already_confirmed }

      context 'verdict with party and judge' do
        let!(:verdict) { create :verdict_for_convert_valid_score, story: story, judges_names: [judge_A.name], party_names: [role.name] }
        it { expect { subject }.to change { ValidScore.count } }
      end
    end

    context 'lawyer' do
      let!(:role) { create :lawyer, :with_confirmed }

      context 'verdict with lawyer and judge' do
        let!(:verdict) { create :verdict_for_convert_valid_score, story: story, judges_names: [judge_A.name], lawyer_names: [role.name] }
        it { expect { subject }.to change { ValidScore.count } }
      end
    end

    context '#valid_score_params' do
      let!(:role) { create :party, :already_confirmed }
      let!(:verdict) { create :verdict_for_convert_valid_score, story: story, judges_names: [judge_A.name], party_names: [role.name] }
      before { subject }

      it { expect(ValidScore.last.story).to eq story }
      it { expect(ValidScore.last.schedule).to eq schedule_score.schedule }
      it { expect(ValidScore.last.judge).to eq schedule_score.judge }
      it { expect(ValidScore.last.score).to eq schedule_score }
      it { expect(ValidScore.last.score_rater).to eq role }
      it { expect(ValidScore.last.attitude_scores).to eq schedule_score.attitude_scores }
      it { expect(ValidScore.last.command_scores).to eq schedule_score.command_scores }
    end
  end
end
