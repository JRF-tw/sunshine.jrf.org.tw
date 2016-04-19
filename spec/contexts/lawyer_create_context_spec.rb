require 'rails_helper'

describe LawyerCreateContext do

  context "success" do 
    let(:params) { attributes_for(:lawyer) }
    subject { described_class.new(params) }
    it { expect { subject.perform }.to change { Lawyer.count }.by(1) }
  end  

  context "name can't be empty" do 
    let(:empty_name) { attributes_for(:empty_name_for_lawyer) }
    subject { described_class.new(empty_name) }
    it { expect { subject.perform }.not_to change{ Lawyer.count } }
  end
end 