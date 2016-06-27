require 'rails_helper'

RSpec.describe Parties::ConfirmationsController, type: :request do
  let!(:party) { FactoryGirl.create :party, confirmation_token: "imtoken" }

  describe "#show" do
    context "validate token" do
      subject { get "/parties/confirmation", confirmation_token: party.confirmation_token }
      it { expect(subject).to redirect_to("/parties/sign_in") }
      it { expect { subject }.to change { Party.last.confirmed? } }
    end

    context "already sign in" do
      before { signin_party(party) }
      subject { get "/parties/confirmation", confirmation_token: party.confirmation_token }

      it { expect(subject).to redirect_to("/parties/profile") }
      it { expect { subject }.to change { party.reload.confirmed? } }
    end

    context "invalidate token" do
      subject { get "/parties/confirmation", confirmation_token: "wwwwwww" }
      it { expect(subject).to redirect_to("/parties/sign_in")  }

      it { expect { subject }.not_to change { Party.last.confirmed? } }
    end
  end

  describe "#create" do
    context "success" do
      let!(:party) { FactoryGirl.create :party, :with_unconfirmed_email}
      before { post "/parties/confirmation", party: { email: party.unconfirmed_email } }

      it { expect(response).to redirect_to("/parties/profile") }
    end
  end

end
