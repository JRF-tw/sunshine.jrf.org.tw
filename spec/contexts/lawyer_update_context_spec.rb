require 'rails_helper'

describe LawyerUpdateContext do
  let!(:lawyer) {FactoryGirl.create :lawyer}
  subject { described_class.new(lawyer) }

  context "success" do 
    let(:params) { attributes_for(:lawyer, :with_gender) }
    it { expect { subject.perform(params) }.to change { lawyer.gender }.to eq(params[:gender]) }
  end  

  context "name can't be empty" do 
    let(:empty_name_params) { attributes_for(:empty_name_for_lawyer) }
    it { expect { subject.perform(empty_name_params) }.not_to change{ lawyer } }
  end
end 