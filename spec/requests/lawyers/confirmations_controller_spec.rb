require "rails_helper"

RSpec.describe Lawyers::ConfirmationsController, type: :request do
  let!(:lawyer) { create :lawyer }

  describe "#show" do
    context "validate token" do
      context "need set password" do
        subject! { get "/lawyer/confirmation", confirmation_token: lawyer.confirmation_token }

        it { expect(response).to be_redirect }
      end

      context "only confirm" do
        let!(:lawyer) { create :lawyer, :with_password }
        subject! { get "/lawyer/confirmation", confirmation_token: lawyer.confirmation_token }

        it { expect(response).to redirect_to("/lawyer/sign_in") }
      end
    end

    context "invalidate token" do
      subject! { get "/lawyer/confirmation", confirmation_token: "wwwwwww" }

      it { expect(response).to redirect_to("/lawyer/sign_in") }
    end
  end

  describe "#create" do
    let!(:lawyer) { signin_lawyer(lawyer_with_unconfirm_email("5566@gmail.com")) }
    subject { post "/lawyer/confirmation", lawyer: { email: lawyer.email } }

    context "send mail success" do
      it { expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end

    context "redirect success" do
      before { subject }
      it { expect(flash[:notice]).to eq("您將在幾分鐘後收到一封電子郵件，內有驗證帳號的步驟說明。") }
      it { expect(response).to redirect_to("/lawyer/profile") }
    end

  end
end
