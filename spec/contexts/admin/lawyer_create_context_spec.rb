require 'rails_helper'

describe Admin::LawyerCreateContext do

  describe "success" do
    let(:params) { attributes_for(:lawyer) }
    subject { described_class.new(params) }

    context "create success" do 
      it { expect { subject.perform }.to change { Lawyer.count }.by(1) }
    end

    context "created should unconfirm" do
      before { subject.perform }
      it { expect(Lawyer.last.confirmed?).to be false }
    end
  end

  context "name can't be empty" do 
    let(:empty_name) { attributes_for(:empty_name_for_lawyer) }
    subject { described_class.new(empty_name) }

    it { expect { subject.perform }.not_to change{ Lawyer.count } }
  end

  context "email can't be empty" do 
    let(:empty_email) { attributes_for(:empty_email_for_lawyer) }
    subject { described_class.new(empty_email) }
    
    it { expect { subject.perform }.not_to change{ Lawyer.count } }
  end
end 
