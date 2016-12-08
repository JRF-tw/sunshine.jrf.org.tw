require 'rails_helper'

describe Admin::ProsecutorDeleteContext do
  let!(:prosecutor) { create(:prosecutor) }

  describe '#perform' do
    context 'success' do
      subject! { described_class.new(prosecutor) }
      it { expect { subject.perform }.to change { Prosecutor.count }.by(-1) }
    end
  end

end
