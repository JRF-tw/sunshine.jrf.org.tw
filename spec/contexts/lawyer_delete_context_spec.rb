require 'rails_helper'

describe LawyerDeleteContext do

  context "success" do
    let!(:lawyer) {FactoryGirl.create :lawyer}
    subject { described_class.new(lawyer) }
    it { expect { subject.perform }.to change { Lawyer.count }.by(-1) }
  end  

  context "has story" do
    let!(:lawyer_with_story) {FactoryGirl.create :lawyer, :with_story}
    subject { described_class.new(lawyer_with_story) }
    it { expect { subject.perform }.not_to change { Lawyer.count } }
  end  
end 