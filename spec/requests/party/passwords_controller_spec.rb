require 'rails_helper'

RSpec.describe Party::RegistrationsController, type: :request do
  let!(:party) { FactoryGirl.create :party }

  describe "#new" do
    context "success" do
      subject! { get "/party/password/new" }

      it { expect(response).to be_success }
    end

    context "if login should redirect" do
      before { signin_party(party) }
      subject! { get "/party/password/new" }

      it { expect(response).to redirect_to("/party/profile") }
    end
  end

  describe "#create" do
    context "success" do
      let!(:params){ { identify_number: party.identify_number, phone_number: party.phone_number } }
      subject! { post "/party/password", party: params }

      it { expect(response).to redirect_to("/party/sign_in") }
    end

    context "failed" do
      let!(:params){ { identify_number: party.identify_number, phone_number: "12312312" } }
      subject! { post "/party/password", { party: params }, {'HTTP_REFERER' => 'http://www.example.com/party/new'} }

      it { expect(response).to be_success }
    end
  end

  describe "#edit" do
    let!(:party) { FactoryGirl.create :party }
    let(:token) { party.send_reset_password_instructions }
    context "success with sign in" do
      before { signin_party(party) }
      subject { get "/party/password/edit", reset_password_token: token }

      it { expect(subject).to eq (200) }
    end

    context "success without sign in" do
      subject { get "/party/password/edit", reset_password_token: token }

      it { expect(subject).to eq (200) }
    end

    context "fail with sign in other party" do
      before { signin_party }
      subject! { get "/party/password/edit", reset_password_token: token }
  
      it { expect(subject).to eq (302) }
    end
  end

  describe "#send_reset_password_sms" do
    before { signin_party }
    context "success" do
      subject! { post "/party/password/send_reset_password_sms" }

      it { expect(response).to redirect_to("/party/profile") }
    end
  end
end
