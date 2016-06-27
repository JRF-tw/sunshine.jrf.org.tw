require 'rails_helper'

RSpec.describe Parties::SessionsController, type: :request do

  describe "#create" do
    let!(:party) { FactoryGirl.create :party }

    xit "check phone varify"

    describe "#create" do
      context "login" do
        let!(:params) { { identify_number: party.identify_number, password: party.password } }
        subject!{ post "/parties/sign_in", party: params }

        it { expect(response).to redirect_to("/parties/profile") }
      end

      context "identify_number nil" do
        let!(:params) { { identify_number: "", password: party.password } }
        subject!{ post "/parties/sign_in", party: params }

        it { expect(response).to be_success }
        it { expect(party.last_sign_in_at).to be_nil }
      end

      context "identify_number unexist" do
        let!(:params) { { identify_number: "A11111111111", password: party.password } }
        subject!{ post "/parties/sign_in", party: params }

        it { expect(response).to be_success }
      end

      context "password error" do
        let!(:params) { { identify_number: party.identify_number, password: "" } }
        subject!{ post "/parties/sign_in", party: params }

        it { expect(response).to be_success }
      end

      context "password error" do
        let!(:params) { { identify_number: party.identify_number, password: "wrong password" } }
        subject!{ post "/parties/sign_in", party: params }

        it { expect(response).to be_success }
      end

      context "root should not change" do
        before { signin_party }

        it { expect(get "/").to render_template("base/index") }
      end
    end

    describe "#destroy" do
      context "sucess" do
        before { signin_party }
        subject!{ delete "/parties/sign_out" }

        it { expect(response).to redirect_to("/parties/sign_in") }
      end

      context "only sign out party" do
      before { signin_lawyer }
      before { signin_party }
      subject! { delete "/parties/sign_out" }

      it { expect(get "/lawyers").to eq(200) }
      it { expect(get "/parties").to eq(302) }
    end
    end
  end
end
