require 'rails_helper'

describe JudgeCreateContext do
  let(:params) { attributes_for(:judge) }

  context "success" do 
    subject { described_class.new(params) }
    it { expect { subject.perform }.to change { Judge.count }.by(1) }
  end  
end 