require 'rails_helper'

describe JudgeUpdateContext do
  let!(:judge) { FactoryGirl.create :judge }
  let(:params) { attributes_for(:judge_for_params) } 
  subject { described_class.new(judge) }

  describe "#perform" do
    context "success" do  
      it { expect { subject.perform(params) }.to change { judge.name }.to eq(params[:name]) } 
    end
  end
    
end  