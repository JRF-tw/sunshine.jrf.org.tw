require 'rails_helper'

RSpec.describe Lawyers::ConfirmationsController, type: :request do
  let!(:lawyer) { FactoryGirl.create :lawyer }

  describe "#show" do
    context "validate token" do
      before { get "/lawyers/confirmation", confirmation_token: lawyer.confirmation_token }
      it { expect(response).to be_success }
    end

    context "invalidate token" do
      before { get "/lawyers/confirmation", confirmation_token: "wwwwwww" }
      it { expect(response).to redirect_to("/lawyers/sign_in")  }
    end
  end

  describe "#confirm" do
    context "success" do
      subject { patch "/lawyers/confirm", lawyer: { password: "55667788", password_confirmation: "55667788", confirmation_token: lawyer.confirmation_token } }
      
      it { expect { subject }.to change { lawyer.reload.encrypted_password } }
      it { expect(subject).to redirect_to("/lawyers/sign_in") }
    end

    context "password caheck failed" do
      subject { patch "/lawyers/confirm", lawyer: { password: "55667788", password_confirmation: "55", confirmation_token: lawyer.confirmation_token } }

      it { expect(subject).to render_template("lawyers/confirmations/show") } 
    end
  end
  
end
