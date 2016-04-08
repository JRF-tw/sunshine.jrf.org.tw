require 'rails_helper'

  describe CourtCreateContext do
  	let(:params) { attributes_for(:court_for_params) }

  	subject { described_class.new(params) }

  	context "success" do 
  	  it { expect { subject.perform }.to change {Court.count}.by(1) }
  	end  
  end	