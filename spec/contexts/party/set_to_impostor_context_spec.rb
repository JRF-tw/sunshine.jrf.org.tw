require 'rails_helper'

describe Party::SetToImpostorContext do
  let!(:party) { create :party, identify_number: 'A225271722', name: '我愛羅' }
  subject { described_class.new(party) }

  describe '#perform' do
    before { subject.perform }
    context 'record identify number' do
      it { expect(party.imposter_identify_number).to eq('A225271722') }
    end

    context 'destroy identify number' do
      it { expect(party.identify_number).to eq('') }
    end

    context 'set to imposter' do
      it { expect(party.imposter).to be_truthy }
    end
  end
end
