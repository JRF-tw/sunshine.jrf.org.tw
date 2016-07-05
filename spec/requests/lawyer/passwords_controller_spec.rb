require "rails_helper"

RSpec.describe Lawyer::PasswordsController, type: :request do

  describe "create" do
    context "email unexist" do
      let!(:params) { { email: "xxxx@gmail.com" } }
      subject! { post "/lawyer/password", { lawyer: params }, "HTTP_REFERER" => "/lawyer/passwords/new" }

      it { expect(response).to redirect_to("/lawyer/passwords/new") }
    end

    context "email unconfirmed" do
      let!(:lawyer) { FactoryGirl.create :lawyer }
      let!(:params) { { email: lawyer.email } }
      subject { post "/lawyer/password", { lawyer: params }, "HTTP_REFERER" => "/lawyer/passwords/new" }

      it { expect(subject).to redirect_to("/lawyer/passwords/new") }
      it { expect { subject }.not_to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end

    context "email confirmed" do
      let!(:lawyer) { FactoryGirl.create :lawyer, :with_password_and_confirmed }
      let!(:params) { { email: lawyer.email } }
      subject { post "/lawyer/password", { lawyer: params }, "HTTP_REFERER" => "/lawyer/passwords/new" }

      it { expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
      it { expect(subject).to redirect_to("/lawyer/sign_in") }
    end
  end

  describe "#edit" do
    let!(:lawyer) { FactoryGirl.create :lawyer }
    let(:token) { lawyer.send_reset_password_instructions }
    context "success with sign in" do
      before { signin_lawyer(lawyer) }
      subject { get "/lawyer/password/edit", reset_password_token: token }

      it { expect(subject).to eq 200 }
    end

    context "success without sign in" do
      subject { get "/lawyer/password/edit", reset_password_token: token }

      it { expect(subject).to eq 200 }
    end

    context "fail with sign in other lawyer" do
      before { signin_lawyer }
      subject! { get "/lawyer/password/edit", reset_password_token: token }

      it { expect(subject).to eq 302 }
    end
  end

  describe "#update" do
    let!(:lawyer) { FactoryGirl.create :lawyer, :with_password_and_confirmed }
    let(:token) { lawyer.send_reset_password_instructions }
    context "success with login" do
      before { signin_lawyer(lawyer) }
      subject! { put "/lawyer/password", lawyer: { password: "55667788", password_confirmation: "55667788", reset_password_token: token } }

      it { expect(response).to redirect_to("/lawyer/profile") }
      it { expect(flash[:notice]).to eq("您的密碼已被修改，下次登入時請使用新密碼登入。") }
    end

    context "success without login" do
      subject! { put "/lawyer/password", lawyer: { password: "55667788", password_confirmation: "55667788", reset_password_token: token } }

      it { expect(response).to redirect_to("/lawyer/profile") }
      it { expect(flash[:notice]).to eq("您的密碼已被修改，下次登入時請使用新密碼登入。") }
    end
  end

  describe "#send_reset_password_mail" do
    before { signin_lawyer }
    subject! { post "/lawyer/password/send_reset_password_mail" }

    it { expect(response).to redirect_to("/lawyer/profile") }
  end

end
