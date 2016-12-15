require 'rails_helper'

describe Admin::CourtDeleteContext do
  let!(:court) { create(:court) }
  subject { described_class.new(court) }

  describe '#perform' do
    context 'success' do
      it { expect { subject.perform }.to change { Court.count }.by(-1) }
    end

    context 'has judge' do
      let!(:judge) { create(:judge, court: court) }
      it { expect { subject.perform }.not_to change { Court.count } }
    end
  end

end
