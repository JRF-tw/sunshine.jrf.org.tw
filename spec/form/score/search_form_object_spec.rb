require 'rails_helper'

RSpec.describe Score::SearchFormObject, type: :model do
  let!(:verdict_score) { create :verdict_score }
  let!(:schedule_score) { create :schedule_score }
  let(:params) { attributes_for :score_search_form_object }
  subject { described_class.new(params) }

  describe '#collect_by_roles' do
    let(:collect_lawyer) { Lawyer.all.map { |j| ["律師 - #{j.name}", j.id] } }
    before { params[:rater_type_eq] = 'Lawyer' }
    it { expect(subject.collect_by_roles).to eq(collect_lawyer) }
  end

  describe '#result' do
    context 'search rater' do
      let!(:same_rater_schedule_score) { create :schedule_score, schedule_rater: verdict_score.verdict_rater }
      before {
        params[:rater_type_eq] = verdict_score.verdict_rater.class.to_s
        params[:rater_id_eq] = verdict_score.verdict_rater.id
      }
      it { expect(subject.result.include?(verdict_score)).to be_truthy }
      it { expect(subject.result.include?(same_rater_schedule_score)).to be_truthy }
    end

    context 'search score_type' do
      before { params[:score_type_eq] = 'VerdictScore' }
      it { expect(subject.result.last).to eq(verdict_score) }
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
