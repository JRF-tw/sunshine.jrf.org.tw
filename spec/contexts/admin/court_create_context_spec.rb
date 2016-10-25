require 'rails_helper'

describe Admin::CourtCreateContext do
  let(:params) { attributes_for(:court_for_params) }

  context 'success' do
    subject { described_class.new(params.merge(weight: '5', is_hidden: '0')) }
    before { subject.perform }
    it { expect(Court.last.weight).to eq(5) }

    context 'add weight if not hidden && court' do
      let(:params) { { is_hidden: '0', court_type: '法院', full_name: '‎臺灣', name: '‎新北' } }
      before { subject.perform }
      it { expect(Court.last.weight).to be_present }
    end
  end

  context 'aleady has the same name' do
    let!(:court) { create :court_for_params }
    subject { described_class.new(params) }
    it { expect { subject.perform }.not_to change { Court.count } }
  end
end
