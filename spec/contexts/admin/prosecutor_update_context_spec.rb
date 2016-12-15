require 'rails_helper'

describe Admin::ProsecutorUpdateContext do
  let!(:prosecutor) { create :prosecutor }
  let(:params) { attributes_for(:prosecutor_for_params) }
  subject { described_class.new(prosecutor) }

  describe '#perform' do
    context 'success' do
      it { expect { subject.perform(params) }.to change { prosecutor.name }.to eq(params[:name]) }
    end

    context "name can't be empty" do
      let(:empty_name) { attributes_for(:empty_name_for_prosecutor) }
      it { expect { subject.perform(empty_name) }.not_to change { prosecutor } }
    end
  end

end
