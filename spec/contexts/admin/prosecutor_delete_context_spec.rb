require 'rails_helper'

describe Admin::ProsecutorDeleteContext do
  let!(:prosecutor) { create(:prosecutor) }
  subject { described_class.new(prosecutor) }
  describe '#perform' do
    context 'success' do
      it { expect { subject.perform }.to change { Prosecutor.count }.by(-1) }
    end

    context 'belongs to judge' do
      let!(:judge) { create(:judge, prosecutor: prosecutor, is_prosecutor: true) }
      before { subject.perform }
      it { expect(judge.reload.is_prosecutor).to eq(false) }
    end
  end

end
