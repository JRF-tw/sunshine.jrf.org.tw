require 'rails_helper'

RSpec.describe Parties::RegistrationsController, type: :request do
  let!(:party) { FactoryGirl.create :party }

  describe "#new" do
    context "success" do
      subject! { get "/parties/password/new" }

      it { expect(response).to be_success }
    end

    context "if login should redirect" do
      before { signin_party(party) }
      subject! { get "/parties/password/new" }

      it { expect(response).to redirect_to("/parties") }
    end
  end

  describe "#create" do
    context "success" do
      let!(:params){ { identify_number: party.identify_number, phone_number: party.phone_number } }
      subject! { post "/parties/password", party: params }

      it { expect(response).to redirect_to("/parties/sign_in") }
    end

    context "failed" do
      let!(:params){ { identify_number: party.identify_number, phone_number: "12312312" } }
      subject! { post "/parties/password", { party: params }, {'HTTP_REFERER' => 'http://www.example.com/parties/new'} }

      it { expect(response).to be_success }
    end
  end

  describe "#send_reset_password_sms" do
    before { signin_party }
    context "success" do
      subject! { post "/parties/password/send_reset_password_sms" }

      it { expect(response).to redirect_to("/parties/profile") }
    end
  end
end
