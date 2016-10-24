require 'rails_helper'

describe Admin::CourtUpdateContext do
  let!(:court) { create :court }
  let(:params) { attributes_for(:court_for_params) }
  subject { described_class.new(court) }

  describe '#perform' do
    context 'success' do
      it { expect { subject.perform(params) }.to change { court.full_name }.to eq(params[:full_name]) }
    end

    context 'update weight' do
      context 'success' do
        before { subject.perform(params) }
        let(:params) { { weight: '12', is_hidden: '0' } }
        it { expect(court.reload.weight).to eq(12) }
      end

      context 'fail' do
        let(:params) { { weight: 'up' } }
        it { expect { subject.perform(params) }.not_to change { court.reload.weight } }
      end
    end

    context 'update is_hidden' do
      before { subject.perform(params) }
      context 'when true remove weight' do
        let!(:court) { create :court, weight: 3 }
        let(:params) { { is_hidden: '1' } }
        it { expect(court.reload.weight).to be_nil }
        it { expect(court.reload.is_hidden).to be_truthy }
      end

      context 'when false && court add weight' do
        let(:params) { { is_hidden: '0' } }
        it { expect(court.reload.weight).to be_present }
        it { expect(court.reload.is_hidden).to be_falsey }
      end
    end

    context 'update court type' do
      before { subject.perform(params) }
      context 'when court && not hidden add weight' do
        let!(:court) { create :court, court_type: '檢察署' }
        let(:params) { { court_type: '法院', is_hidden: '0' } }
        it { expect(court.reload.weight).to be_present }
      end

      context 'when prosecutor remove weight' do
        let!(:court) { create :court, weight: 3 }
        let(:params) { { court_type: '檢察署' } }
        it { expect(court.reload.weight).to be_nil }
      end
    end
  end

end
