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

  describe "#set_phone?" do
    context "phone_number nil should redirect" do
      before { signin_party.update_attributes(phone_number: nil) }
      subject!{ get "/party" }

      it { expect(response).to redirect_to("/party/phone/new") }
    end
  end
end
