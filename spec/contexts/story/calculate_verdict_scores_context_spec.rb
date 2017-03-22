require 'rails_helper'

describe Story::CalculateVerdictScoresContext do
  let!(:story) { create :story, :pronounced }
  let!(:verdict_score) { create :verdict_score, :by_party, story: story }
  let!(:judge_A) { create :judge }
  let!(:verdict) { create :verdict_for_convert_valid_score, story: story, judges_names: [judge_A.name], party_names: [verdict_score.verdict_rater.name] }
  subject { described_class.new(story) }

  describe '#perform' do
    it { expect { subject.perform }.to change { ValidScore.count } }
    it { expect { subject.perform }.to change { story.is_calculated }.to be_truthy }
  end
end
