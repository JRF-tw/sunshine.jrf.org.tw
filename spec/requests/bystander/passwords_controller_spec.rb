require 'rails_helper'

RSpec.describe Bystander::PasswordsController, type: :request do
  let!(:bystander) { FactoryGirl.create :bystander }
  let(:token) { bystander.send_reset_password_instructions }

  describe "#update" do
    context "success" do
      before { put "/bystander/password", bystander: { password: "55667788", password_confirmation: "55667788", reset_password_token: token } }
      subject { post "/bystander/sign_in", bystander: { email: bystander.email, password: "55667788" } }

      it { expect(response).to redirect_to("/bystander/profile") }
      it "sign in with updated password" do
        signout_bystander
        expect { subject }.to change { bystander.reload.current_sign_in_at }
      end
    end
  end

  describe "#edit" do
    context "success with sign in" do
      before { signin_bystander(bystander) }
      subject { get "/bystander/password/edit", reset_password_token: token }

      it { expect(subject).to eq 200 }
    end

    context "success without sign in" do
      subject { get "/bystander/password/edit", reset_password_token: token }

      it { expect(subject).to eq 200 }
    end

    context "fail with sign in other bystander" do
      before { signin_bystander }
      subject! { get "/bystander/password/edit", reset_password_token: token }

      it { expect(subject).to eq 302 }
    end
  end

  describe "#send_reset_password_mail" do
    before { signin_bystander }
    subject! { post "/bystander/password/send_reset_password_mail" }

    it { expect(response).to redirect_to("/bystander/profile") }
  end

end
