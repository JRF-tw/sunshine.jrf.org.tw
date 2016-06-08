require 'rails_helper'

RSpec.describe Bystanders::RegistrationsController, :type => :request do

  describe "#update" do
    before { signin_bystander }
    let!(:bystander) { current_bystander }
    let!(:old_email) { bystander.email }

    context "update email" do
      subject { put "/bystanders", bystander: { email: "h2312@gmail.com", current_password: "123123123"} }
      it { expect(subject).to redirect_to("/bystanders")}
      it { expect{ subject }.to change { bystander.reload.unconfirmed_email } }
      
    end

    context "update same email" do
      subject { put "/bystanders", bystander: { email: current_bystander.email, current_password: "123123123"} }
      it { expect{ subject }.not_to change { bystander.reload.unconfirmed_email } }
    end

    context "update used email" do
      let!(:bystander2) { FactoryGirl.create :bystander, :with_unconfirmed_email  }
      before { put "/bystanders", bystander: { email: bystander2.unconfirmed_email, current_password: "123123123"} }
      
      it { expect{ subject }.not_to change { bystander.reload.unconfirmed_email } }
    end

    context "sign in after updated" do
      before { put "/bystanders", bystander: { email: "h2312@gmail.com", current_password: "123123123"} }
      before { signout_bystander }
      subject { post "/bystanders/sign_in", bystander: { email: bystander.email, password: "123123123" } }

      it { expect{ subject }.to change { bystander.reload.current_sign_in_at } }
    end

    context "sign in new email after updated and confirm" do
      before { put "/bystanders", bystander: { email: "h2312@gmail.com", current_password: "123123123"} }
      before { signout_bystander }
      before { get "/bystanders/confirmation", confirmation_token: bystander.reload.confirmation_token }

      subject { post "/bystanders/sign_in", bystander: { email: "h2312@gmail.com", password: "123123123" } }
      it { expect{ subject }.to change { bystander.reload.current_sign_in_at } }
    end

    context "sign in old email after updated and confirm" do
      before { put "/bystanders", bystander: { email: "h2312@gmail.com", current_password: "123123123"} }
      before { signout_bystander }
      before { get "/bystanders/confirmation", confirmation_token: bystander.reload.confirmation_token }

      subject { post "/bystanders/sign_in", bystander: { email: old_email, password: "123123123" } }
      it { expect{ subject }.to_not change { bystander.reload.current_sign_in_at } }
    end

  end

end
