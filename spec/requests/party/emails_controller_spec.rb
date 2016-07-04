require 'rails_helper'

RSpec.describe Party::EmailsController, type: :request do
  before { signin_party }

  describe "#edit" do
    before { signin_party }
    subject! { get "/party/email/edit" }
    it { expect(response).to be_success }
  end

  describe "#update" do
    context "success" do
      before { signin_party }
      subject! { put "/party/email", party: { email: "5566@gmail", current_password: "12321313213" } }
      it { expect(response).to redirect_to("/party/profile") }
    end

    context "wrong password" do
      before { signin_party }
      subject! { put "/party/email", party: { email: "5566@gmail", current_password: "" } }

      it { expect { subject }.not_to change { current_party } }
      it { expect(response.body).not_to match("目前等待驗證中信箱") }
    end
  end
end
