require 'rails_helper'

RSpec.describe Defendants::RegistrationsController, type: :request do
  let!(:defendant) { FactoryGirl.create :defendant }

  describe "#new" do
    context "success" do
      subject! { get "/defendants/password/new" }

      it { expect(response).to be_success }
    end

    context "if login should redirect" do
      before { signin_defendant(defendant) }
      subject! { get "/defendants/password/new" }

      it { expect(response).to redirect_to("/defendants") }
    end
  end

  describe "#create" do
    context "success" do
      let!(:params){ { identify_number: defendant.identify_number, phone_number: defendant.phone_number } }
      subject! { post "/defendants/password", defendant: params }

      it { expect(response).to redirect_to("/defendants/sign_in") }
    end

    context "failed" do
      let!(:params){ { identify_number: defendant.identify_number, phone_number: "12312312" } }
      subject! { post "/defendants/password", { defendant: params }, {'HTTP_REFERER' => 'http://www.example.com/defendants/new'} }

      it { expect(response).to be_success }
    end
  end

  describe "#send_reset_password_sms" do
    before { signin_defendant }
    context "success" do
      subject! { post "/defendants/password/send_reset_password_sms" }
      
      it { expect(response).to redirect_to("/defendants/profile") }
    end
  end
end
