require 'rails_helper'

describe Scrap::VerdictScoreConvertContext do
  let!(:story) { create :story, :pronounced }
  let(:verdict_score) { create :verdict_score_for_params, story: story, verdict_rater: role }
  let!(:judge_A) { create :judge }
  let!(:judge_B) { create :judge }
  subject { described_class.new(verdict_score).perform }

  context '#perform' do
    context 'party' do
      let!(:role) { create :party, :already_confirmed }

      context 'verdict with party and judges' do
        let!(:verdict) { create :verdict, :create_relation_by_role_name, is_judgment: true, story: story, judges_names: [judge_A.name, judge_B.name], party_names: [role.name] }
        it { expect { subject }.to change { ValidScore.count }.by(2) }
      end
    end

    context 'lawyer' do
      let!(:role) { create :lawyer, :with_confirmed }

      context 'verdict with lawyer and judges' do
        let!(:verdict) { create :verdict, :create_relation_by_role_name, is_judgment: true, story: story, judges_names: [judge_A.name, judge_B.name], lawyer_names: [role.name] }
        it { expect { subject }.to change { ValidScore.count }.by(2) }
      end
    end

    context '#valid_score_params' do
      let!(:role) { create :party, :already_confirmed }
      let!(:verdict) { create :verdict, :create_relation_by_role_name, is_judgment: true, story: story, judges_names: [judge_A.name], party_names: [role.name] }
      before { subject }

      it { expect(ValidScore.last.story).to eq story }
      it { expect(ValidScore.last.judge).to eq judge_A }
      it { expect(ValidScore.last.score).to eq verdict_score }
      it { expect(ValidScore.last.score_rater).to eq role }
      it { expect(ValidScore.last.quality_scores).to eq verdict_score.quality_scores }
    end
  end
end
