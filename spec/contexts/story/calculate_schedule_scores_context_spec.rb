require 'rails_helper'

describe Story::CalculateScheduleScoresContext do
  let!(:story) { create :story, :pronounced }
  let!(:schedule_score) { create :schedule_score, story: story, judge: judge_A }
  let!(:judge_A) { create :judge }
  let!(:verdict) { create :verdict_for_convert_valid_score, story: story, judges_names: [judge_A.name], lawyer_names: [schedule_score.schedule_rater.name] }
  subject { described_class.new(story) }

  describe '#perform' do
    it { expect { subject.perform }.to change { ValidScore.count } }
  end
end
