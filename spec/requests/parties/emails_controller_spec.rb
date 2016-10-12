require "rails_helper"

RSpec.describe Parties::EmailsController, type: :request do
  describe "#edit" do
    before { signin_party }
    subject! { get "/party/email/edit" }
    it { expect(response).to be_success }
  end

  describe "#update" do
    before { signin_party }
    context "success" do
      subject { put "/party/email", party: { email: "5566@gmail.com", current_password: "12321313213" } }
      it { expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
      it { expect(subject).to redirect_to("/party/profile") }
    end

    context "wrong password" do
      subject! { put "/party/email", party: { email: "5566@gmail.com", current_password: "" } }

      it { expect(current_party.email).not_to eq("5566@gmail.com") }
      it { expect(response.body).to match("5566@gmail.com") }
      it { expect(response.body).not_to match("目前等待驗證中信箱") }
    end
  end

  describe "#resend_confirmation_mail" do
    let!(:party) { create :party, :with_unconfirmed_email, :with_confirmation_token }
    before { signin_party(party) }
    subject { post "/party/email/resend_confirmation_mail" }

    it { expect { subject }.to change_sidekiq_jobs_size_of(CustomDeviseMailer, :resend_confirmation_instructions) }

    context "redirect success" do
      before { subject }
      it { expect(flash[:notice]).to eq("您將在幾分鐘後收到一封電子郵件，內有驗證帳號的步驟說明。") }
      it { expect(response).to redirect_to("/party/profile") }
    end
  end
end
