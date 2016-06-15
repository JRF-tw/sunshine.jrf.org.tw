require 'rails_helper'

RSpec.describe Defendants::PhonesController, type: :request do
  before { signin_defendant }

  describe "#new" do
    subject!{ get "/defendants/phone/new" }
    it { expect(response).to be_success }
  end

  describe "#create" do
    context "success" do
      subject!{ post "/defendants/phone", defendant: { phone_number: "0911111111" } }
      it { expect(response).to redirect_to("/defendants/phone/verify") }
    end

    context "failed" do
      subject!{ post "/defendants/phone", defendant: { phone_number: nil } }
      it { expect(response).to be_success }
    end
  end

  describe "#edit" do
    subject!{ get "/defendants/phone/edit" }
    it { expect(response).to be_success }
  end

  describe "#update" do
    context "success" do
      subject!{ put "/defendants/phone", defendant: { phone_number: "0911111111" } }
      it { expect(response).to redirect_to("/defendants/phone/verify") }
    end

    context "failed" do
      subject!{ put "/defendants/phone", defendant: { phone_number: nil } }
      it { expect(response).to be_success }
    end
  end

  describe "#verify" do
    before { current_defendant.phone_varify_code = "1111" }

    context "success" do
      subject!{ get "/defendants/phone/verify" }
      it { expect(response).to be_success }
    end
  end

  describe "#verifing" do
    before { current_defendant.phone_varify_code = "1111" }

    context "success" do
      subject!{ put "/defendants/phone/verifing", defendant: { phone_varify_code: "1111" } }
      it { expect(response).to redirect_to("/defendants/profile") }
    end
  end

  describe "#resend" do
    before { current_defendant.phone_varify_code = "1111" }

    context "success" do
      subject!{ put "/defendants/phone/resend" }
      it { expect(response).to redirect_to("/defendants/phone/verify") }
    end
  end

  describe "#can_verify?" do
    context "success" do
      before { current_defendant.phone_varify_code = "1111" }
      subject!{ get "/defendants/phone/verify" }

      it { expect(response).to be_success }
    end

    context "should set phone_number" do
      subject!{ get "/defendants/phone/verify" }

      it { expect(response).to redirect_to("/defendants/phone/edit") }
    end

  end
end
