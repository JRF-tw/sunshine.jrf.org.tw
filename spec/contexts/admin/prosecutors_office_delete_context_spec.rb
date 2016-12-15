require 'rails_helper'

describe Admin::ProsecutorsOfficeDeleteContext do
  let!(:prosecutors_office) { create(:prosecutors_office) }
  subject { described_class.new(prosecutors_office) }

  describe '#perform' do
    context 'success' do
      it { expect { subject.perform }.to change { ProsecutorsOffice.count }.by(-1) }
    end

    context 'has prosecutor' do
      let!(:prosecutor) { create(:prosecutor, prosecutors_office: prosecutors_office) }
      it { expect { subject.perform }.not_to change { ProsecutorsOffice.count } }
    end
  end

end
