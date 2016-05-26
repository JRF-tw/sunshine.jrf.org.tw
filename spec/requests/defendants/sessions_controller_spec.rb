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

      context "login failed" do
        let!(:params) { { identify_number: defendant.identify_number, password: "xxxxx" } }
        subject!{ post "/defendants/sign_in", defendant: params }

        it { expect(response).to be_success }
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
