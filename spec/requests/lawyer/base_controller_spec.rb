require 'rails_helper'

RSpec.describe Lawyer::BaseController, type: :request do

  describe "#index" do
    context "login" do
      before { signin_lawyer }
      subject!{ get "/lawyer" }
      it { expect(response).to be_success }
    end
  end

  describe "#authenticate_lawyer" do
    context "login" do
      before { signin_lawyer }
      subject!{ get "/lawyer/profile" }
      it { expect(response).to be_success }
    end

    context "not login" do
      subject!{ get "/lawyer/profile" }
      it { expect(response).to redirect_to("/lawyer/sign_in") }
    end
  end

  describe "#edit_profile" do
    before { signin_lawyer }
    subject!{ get "/lawyer/edit-profile" }
    it { expect(response).to be_success }
  end

  describe "#update_profile" do
    before { signin_lawyer }
    subject!{ post "/lawyer/update_profile", lawyer: { current: "律師事務所" } }
    it { expect(response).to redirect_to("/lawyer/profile") }
  end

end
