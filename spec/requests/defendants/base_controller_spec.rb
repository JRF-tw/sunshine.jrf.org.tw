require 'rails_helper'

RSpec.describe Defendants::BaseController, type: :request do

  describe "#index" do
    context "login" do
      before { signin_defendant }

      subject!{ get "/defendants" }
      it { expect(response).to be_success }
    end

    context "login & phone_number nil" do
      before { signin_defendant.update_attributes(phone_number: nil) }
      subject!{ get "/defendants" }

      it { expect(response).to redirect_to("/defendants/phone/new") }
    end

    context "not login" do
      subject!{ get "/defendants" }
      it { expect(response).to be_redirect }
    end
  end

  describe "#profile" do
    before { signin_defendant }
    subject!{ get "/defendants/profile" }
    it { expect(response).to be_success }
  end

  describe "#edit_email" do
    before { signin_defendant }
    subject!{ get "/defendants/edit-email" }
    it { expect(response).to be_success }
  end

  describe "#update_email" do
    context "success" do
      before { signin_defendant }
      subject!{ put "/defendants/update-email", defendant: { email: "5566@gmail", current_password: "12321313213" } }
      it { expect(response).to redirect_to("/defendants/profile")}
    end

    context "wrong password" do
      before { signin_defendant }
      subject!{ put "/defendants/update-email", defendant: { email: "5566@gmail", current_password: "" } }
    
      it { expect { subject }.not_to change { current_defendant } }
      it { expect(response.body).not_to match("目前等待驗證中信箱") }
    end
  end
end
