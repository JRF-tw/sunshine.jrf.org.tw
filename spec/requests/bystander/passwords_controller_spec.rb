require "rails_helper"

RSpec.describe Bystander::PasswordsController, type: :request do
  let!(:bystander) { FactoryGirl.create :bystander }
  let(:token) { bystander.send_reset_password_instructions }

  describe "#update" do
    context "success with login" do
      before { signin_bystander(bystander) }
      subject! { put "/bystander/password", bystander: { password: "55667788", password_confirmation: "55667788", reset_password_token: token } }

      it { expect(response).to redirect_to("/bystander/profile") }
      it { expect(flash[:notice]).to eq("您的密碼已被修改，下次登入時請使用新密碼登入。") }
    end

    context "success without login" do
      subject! { put "/bystander/password", bystander: { password: "55667788", password_confirmation: "55667788", reset_password_token: token } }

      it { expect(response).to redirect_to("/bystander/profile") }
      it { expect(flash[:notice]).to eq("您的密碼已被修改，下次登入時請使用新密碼登入。") }
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
