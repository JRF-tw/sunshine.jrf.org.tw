require 'rails_helper'

describe Admin::CourtUpdateContext do
  let!(:court) { FactoryGirl.create :court }
  let(:params) { attributes_for(:court_for_params) }
  subject { described_class.new(court) }

  describe "#perform" do
    context "success" do	
      it { expect { subject.perform(params) }.to change { court.full_name }.to eq(params[:full_name]) }	
    end
  end
    
end  
