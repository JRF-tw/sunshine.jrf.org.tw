require 'rails_helper'

describe Admin::ProsecutorCreateContext do
  let(:params) { attributes_for(:prosecutor_for_params) }

  context 'success' do
    subject { described_class.new(params) }
    it { expect { subject.perform }.to change { Prosecutor.count }.by(1) }
  end

  context "name can't be empty" do
    let(:empty_name) { attributes_for(:empty_name_for_prosecutor) }
    subject { described_class.new(empty_name) }
    it { expect { subject.perform }.not_to change { Prosecutor.count } }
  end
end
