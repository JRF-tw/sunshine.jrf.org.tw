require 'rails_helper'

describe Admin::ProsecutorsOfficeDeleteContext do
  let(:prosecutors_office) { create(:prosecutors_office) }

  describe '#perform' do
    context 'success' do
      subject! { described_class.new(prosecutors_office) }
      it { expect { subject.perform }.to change { ProsecutorsOffice.count }.by(-1) }
    end
  end

end
