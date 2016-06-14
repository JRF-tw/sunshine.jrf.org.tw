require 'rails_helper'

describe Defendant::ChangeEmailContext do
  let!(:defendant) { FactoryGirl.create :defendant, unconfirmed_email: "hh@gmail.com" }
  subject { described_class.new(defendant) }

  describe "perform" do
    context "success" do
      let(:params) { { unconfirmed_email: "h2312@gmail.com", current_password: "12321313213" } }
      

      it { expect{ subject.perform(params) }.to change { defendant.reload.unconfirmed_email } }
    end

    context "email already exist" do
      let!(:defendant2) { FactoryGirl.create :defendant, email: "55667788@gmail.com"   }
      let(:params) { { unconfirmed_email: defendant2.email, current_password: "12321313213" } }
      it { expect{ subject.perform(params) }.not_to change { defendant.reload.unconfirmed_email } }
    end

    context "empty email" do
      let(:params) { { unconfirmed_email: "", current_password: "12321313213" } }
      it { expect{ subject.perform(params) }.not_to change { defendant.reload.unconfirmed_email } }
    end
    
    context "empty password" do
      let(:params) { { unconfirmed_email: "h2312@gmail.com", current_password: "" } }
      it { expect{ subject.perform(params) }.not_to change { defendant.reload.unconfirmed_email } }
    end

    context "update the same email" do
      let(:params) { { unconfirmed_email: defendant.email, current_password: "12321313213" } }

      it { expect{ subject.perform(params) }.not_to change { defendant.reload.unconfirmed_email } }
    end

    context "update other's unconfirmed_email" do
      let!(:defendant2) { FactoryGirl.create :defendant, unconfirmed_email: "55667788@gmail.com"   }
      let(:params) { { unconfirmed_email: defendant2.unconfirmed_email, current_password: "12321313213" } }

      it { expect{ subject.perform(params) }.not_to change { defendant.reload.unconfirmed_email } }
    end
  end

end
