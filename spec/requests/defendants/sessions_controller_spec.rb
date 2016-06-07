require 'rails_helper'

RSpec.describe Defendants::SessionsController, type: :request do

  describe "#create" do
    let!(:defendant) { FactoryGirl.create :defendant }

    xit "check phone varify"

    describe "#create" do
      context "login" do
        let!(:params) { { identify_number: defendant.identify_number, password: defendant.password } }
        subject!{ post "/defendants/sign_in", defendant: params }

        it { expect(response).to redirect_to("/defendants") }
      end

      context "identify_number nil" do
        let!(:params) { { identify_number: "", password: defendant.password } }
        subject!{ post "/defendants/sign_in", defendant: params }

        it { expect(response).to be_success }
        it { expect(defendant.last_sign_in_at).to be_nil }
      end

      context "identify_number unexist" do
        let!(:params) { { identify_number: "A11111111111", password: defendant.password } }
        subject!{ post "/defendants/sign_in", defendant: params }

        it { expect(response).to be_success }
      end

      context "password error" do
        let!(:params) { { identify_number: defendant.identify_number, password: "" } }
        subject!{ post "/defendants/sign_in", defendant: params }

        it { expect(response).to be_success }
      end

      context "password error" do
        let!(:params) { { identify_number: defendant.identify_number, password: "wrong password" } }
        subject!{ post "/defendants/sign_in", defendant: params }

        it { expect(response).to be_success }
      end

      context "root should not change" do
        before { signin_defendant }

        it { expect(get "/").to render_template("base/index") }
      end
    end

    describe "#destroy" do
      context "sucess" do
        before { signin_defendant }
        subject!{ delete "/defendants/sign_out" }

        it { expect(response).to redirect_to("/defendants/sign_in") }
      end
    end
  end
end
