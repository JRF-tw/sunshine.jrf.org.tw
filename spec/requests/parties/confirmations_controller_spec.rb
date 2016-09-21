require "rails_helper"

RSpec.describe Parties::ConfirmationsController, type: :request do
  let!(:party) { create :party, confirmation_token: "imtoken" }

  describe "#show" do
    context "validate token" do
      subject { get "/party/confirmation", confirmation_token: party.confirmation_token }
      it { expect(subject).to redirect_to("/party/sign_in") }
      it { expect { subject }.to change { Party.last.confirmed? } }
    end

    context "already sign in" do
      before { signin_party(party) }
      subject { get "/party/confirmation", confirmation_token: party.confirmation_token }

      it { expect(subject).to redirect_to("/party/profile") }
      it { expect { subject }.to change { party.reload.confirmed? } }
    end

    context "invalidate token" do
      subject { get "/party/confirmation", confirmation_token: "wwwwwww" }
      it { expect(subject).to redirect_to("/party/sign_in") }

      it { expect { subject }.not_to change { Party.last.confirmed? } }
    end
  end

  describe "#create" do
    let(:party_with_confirmed_email) { signin_party(party_with_unconfirm_email) }
    subject { post "/party/confirmation", party: { email: party.email } }

    context "success send mail" do
      it { expect { subject }.to change_sidekiq_jobs_size_of(Devise::Async::Backend::Sidekiq) }
    end

    context "success render" do
      before { subject }
      it { expect(flash[:notice]).to eq("您將在幾分鐘後收到一封電子郵件，內有驗證帳號的步驟說明。") }
      it { expect(response).to be_redirect }
    end
  end

end
