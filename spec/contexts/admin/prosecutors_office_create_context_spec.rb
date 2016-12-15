require 'rails_helper'

describe Admin::ProsecutorsOfficeCreateContext do
  let(:params) { attributes_for(:prosecutors_office_for_params) }

  context 'success' do
    subject { described_class.new(params) }
    before { subject.perform }
    it { expect(ProsecutorsOffice.count).to eq(1) }
  end

  context 'fail' do
    context 'without court' do
      let(:params) { attributes_for(:prosecutors_office_without_court) }
      subject { described_class.new(params) }
      it { expect { subject.perform }.not_to change { ProsecutorsOffice.count } }
    end

    context 'aleady has the same name' do
      let!(:prosecutors_office) { create :prosecutors_office_for_params }
      subject { described_class.new(params) }
      it { expect { subject.perform }.not_to change { ProsecutorsOffice.count } }
    end

    context 'full_name  empty' do
      let(:empty_name) { attributes_for(:empty_full_name_for_prosecutors_office) }
      subject { described_class.new(empty_name) }
      it { expect { subject.perform }.not_to change { ProsecutorsOffice.count } }
    end
  end
end
