require 'rails_helper'

RSpec.describe Lawyers::PasswordsController, type: :request do

  describe "create" do
    context "email unexist" do
      let!(:params){ { email: "xxxx@gmail.com" } }
      subject! { post "/lawyers/password", { lawyer: params }, { 'HTTP_REFERER' => '/lawyers/passwords/new' } }

      it { expect(response).to redirect_to("/lawyers/passwords/new") }
    end

    context "email unconfirmed" do
      let!(:lawyer) { FactoryGirl.create :lawyer }
      let!(:params){ { email: lawyer.email } }
      subject! { post "/lawyers/password", { lawyer: params }, { 'HTTP_REFERER' => '/lawyers/passwords/new' } }

      it { expect(response).to redirect_to("/lawyers/passwords/new") }
    end

    context "email confirmed" do
      let!(:lawyer) { FactoryGirl.create :lawyer, :with_password_and_confirmed }
      let!(:params){ { email: lawyer.email } }
      subject { post "/lawyers/password", { lawyer: params }, { 'HTTP_REFERER' => '/lawyers/passwords/new' } }

      it { expect{ subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }

      context "redirect sign_in" do
        before { subject }
        it { expect(response).to redirect_to("/lawyers/sign_in") }
      end
    end
  end

  describe "#update" do
    let!(:lawyer) { FactoryGirl.create :lawyer }
    let!(:token) { lawyer.send_reset_password_instructions }
    subject { put "/lawyers/password", lawyer: { password: "55667788", password_confirmation: "55667788", reset_password_token: token } }

    it { expect { subject }.not_to change { lawyer.reload.current_sign_in_at } }
    it { expect { subject }.to change { lawyer.reload.encrypted_password } }

    context "redirect_to login" do
      before { subject }
      it { expect(response).to redirect_to("/lawyers/sign_in") }
    end
  end

  describe "#send_reset_password_mail" do
    before { signin_lawyer }
    subject! { post "/lawyers/password/send_reset_password_mail" }

    it { expect(response).to redirect_to("/lawyers/profile") }
  end

end
