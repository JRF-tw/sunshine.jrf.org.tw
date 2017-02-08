require 'rails_helper'

RSpec.describe Score::SearchFormObject, type: :model do
  let!(:verdict_score) { create :verdict_score }
  let!(:schedule_score) { create :schedule_score }
  let(:params) { { score_type_eq: '', judge_id_eq: '', story_id_eq: '', rater_type_eq: '', rater_id_eq: '', created_at_gteq: '', created_at_lteq: '' } }
  subject { described_class.new(params) }

  describe '#result' do
    context 'search rater' do
      before {
        params[:rater_type_eq] = verdict_score.verdict_rater.class.to_s
        params[:rater_id_eq] = verdict_score.verdict_rater.id
      }
      it { expect(subject.result.last).to eq(verdict_score) }
    end

    context 'search score_type' do
      before { params[:score_type_eq] = 'ScheduleScore' }
      it { expect(subject.result.last).to eq(schedule_score) }
    end

    context 'search judge_id' do
      context 'id exist' do
        before { params[:judge_id_eq] = schedule_score.judge_id }
        it { expect(subject.result.last).to eq(schedule_score) }
      end

      context 'id not_exist' do
        before { params[:judge_id_eq] = schedule_score.judge_id + 10 }
        it { expect(subject.result).to be_empty }
      end
    end
  end
end
