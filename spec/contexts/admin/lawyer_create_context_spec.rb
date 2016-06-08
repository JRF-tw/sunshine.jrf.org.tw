require 'rails_helper'

describe Admin::LawyerCreateContext do

  describe "perform" do
    context "create success" do 
      let(:params) { attributes_for(:lawyer) }
      subject { described_class.new(params) }

      it { expect { subject.perform }.to change { Lawyer.count }.by(1) }
    end

    context "created should unconfirm" do
      let(:params) { attributes_for(:lawyer) }
      before { subject.perform }
      subject { described_class.new(params) }
      
      it { expect(Lawyer.last.confirmed?).to be false }
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
end 
