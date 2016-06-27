require 'rails_helper'

RSpec.describe Party::BaseController, type: :request do

  describe "#index" do
    context "login" do
      before { signin_party }

      subject!{ get "/party" }
      it { expect(response).to be_success }
    end

    context "not login" do
      subject!{ get "/party" }
      it { expect(response).to be_redirect }
    end
  end

  describe "#profile" do
    before { signin_party }
    subject!{ get "/party/profile" }
    it { expect(response).to be_success }
  end

  describe "#edit_email" do
    before { signin_party }
    subject!{ get "/party/edit-email" }
    it { expect(response).to be_success }
  end

  describe "#update_email" do
    context "success" do
      before { signin_party }
      subject!{ put "/party/update-email", party: { email: "5566@gmail", current_password: "12321313213" } }
      it { expect(response).to redirect_to("/party/profile")}
    end

    context "wrong password" do
      before { signin_party }
      subject!{ put "/party/update-email", party: { email: "5566@gmail", current_password: "" } }

      it { expect { subject }.not_to change { current_party } }
      it { expect(response.body).not_to match("目前等待驗證中信箱") }
    end
  end

  describe "#set_phone?" do
    context "phone_number nil should redirect" do
      before { signin_party.update_attributes(phone_number: nil) }
      subject!{ get "/party" }

      it { expect(response).to redirect_to("/party/phone/new") }
    end
  end
end
