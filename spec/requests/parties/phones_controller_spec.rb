require 'rails_helper'

RSpec.describe Parties::PhonesController, type: :request do
  before { signin_party }

  describe "#new" do
    subject!{ get "/parties/phone/new" }
    it { expect(response).to be_success }
  end

  describe "#create" do
    context "success" do
      subject!{ post "/parties/phone", party: { phone_number: "0911111111" } }
      it { expect(response).to redirect_to("/parties/phone/verify") }
    end

    context "failed" do
      subject!{ post "/parties/phone", party: { phone_number: nil } }
      it { expect(response).to be_success }
    end
  end

  describe "#edit" do
    subject!{ get "/parties/phone/edit" }
    it { expect(response).to be_success }
  end

  describe "#update" do
    context "success" do
      subject!{ put "/parties/phone", party: { phone_number: "0911111111" } }
      it { expect(response).to redirect_to("/parties/phone/verify") }
    end

    context "failed" do
      subject!{ put "/parties/phone", party: { phone_number: nil } }
      it { expect(response).to be_success }
    end
  end

  describe "#verify" do
    before { current_party.phone_varify_code = "1111" }

    context "success" do
      subject!{ get "/parties/phone/verify" }
      it { expect(response).to be_success }
    end
  end

  describe "#verifing" do
    before { current_party.phone_varify_code = "1111" }

    context "success" do
      subject!{ put "/parties/phone/verifing", party: { phone_varify_code: "1111" } }
      it { expect(response).to redirect_to("/parties/profile") }
    end
  end

  describe "#resend" do
    before { current_party.phone_varify_code = "1111" }

    context "success" do
      subject!{ put "/parties/phone/resend" }
      it { expect(response).to redirect_to("/parties/phone/verify") }
    end
  end

  describe "#can_verify?" do
    context "success" do
      before { current_party.phone_varify_code = "1111" }
      subject!{ get "/parties/phone/verify" }

      it { expect(response).to be_success }
    end

    context "should set phone_number" do
      subject!{ get "/parties/phone/verify" }

      it { expect(response).to redirect_to("/parties/phone/edit") }
    end

  end
end
