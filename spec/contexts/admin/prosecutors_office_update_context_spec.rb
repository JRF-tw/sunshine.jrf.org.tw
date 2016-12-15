require 'rails_helper'

describe Admin::ProsecutorsOfficeUpdateContext do
  let!(:prosecutors_office) { create :prosecutors_office }
  let(:params) { attributes_for(:prosecutors_office_for_params) }
  subject { described_class.new(prosecutors_office) }

  describe '#perform' do
    context 'success' do
      it { expect { subject.perform(params) }.to change { prosecutors_office.full_name }.to eq(params[:full_name]) }
    end

    context 'fail' do
      context 'without court' do
        let(:params) { attributes_for(:prosecutors_office_without_court) }
        it { expect { subject.perform(params) }.not_to change { ProsecutorsOffice.count } }
      end

      context 'aleady has the same name' do
        let!(:prosecutors_office) { create :prosecutors_office_for_params }
        it { expect { subject.perform(params) }.not_to change { ProsecutorsOffice.count } }
      end

      context 'full_name empty' do
        let(:empty_name) { attributes_for(:empty_full_name_for_prosecutors_office) }
        it { expect { subject.perform(empty_name) }.not_to change { ProsecutorsOffice.count } }
      end
    end
  end

end
