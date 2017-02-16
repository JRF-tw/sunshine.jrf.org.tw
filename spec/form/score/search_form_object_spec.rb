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
end
