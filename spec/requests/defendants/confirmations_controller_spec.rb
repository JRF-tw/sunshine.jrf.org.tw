require 'rails_helper'

RSpec.describe Defendants::ConfirmationsController, type: :request do
  let!(:defendant) { FactoryGirl.create :defendant, confirmation_token: "imtoken" }

  describe "#show" do
    context "validate token" do
      subject { get "/defendants/confirmation", confirmation_token: defendant.confirmation_token }
      it { expect(subject).to redirect_to("/defendants/sign_in") }
      it { expect { subject }.to change { Defendant.last.confirmed? } }
    end

    context "already sign in" do
      before { signin_defendant(defendant) }
      subject { get "/defendants/confirmation", confirmation_token: defendant.confirmation_token }

      it { expect(subject).to redirect_to("/defendants/profile") }
      it { expect { subject }.to change { defendant.reload.confirmed? } }
    end

    context "invalidate token" do
      subject { get "/defendants/confirmation", confirmation_token: "wwwwwww" }
      it { expect(subject).to redirect_to("/defendants/sign_in")  }

      it { expect { subject }.not_to change { Defendant.last.confirmed? } }
    end
  end

  describe "#create" do
    context "success" do
      let!(:defendant) { FactoryGirl.create :defendant, :with_unconfirmed_email}
      before { post "/defendants/confirmation", defendant: { email: defendant.unconfirmed_email } }
      
      it { expect(response).to redirect_to("/defendants/profile") }
    end
  end

end
