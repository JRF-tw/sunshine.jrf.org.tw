require 'rails_helper'

RSpec.describe Lawyers::BaseController, type: :request do

  describe "#index" do
    context "login" do
      before { signin_lawyer }
      subject!{ get "/lawyers" }
      it { expect(response).to be_success }
    end
  end

  describe "#authenticate_lawyer" do
    context "login" do
      before { signin_lawyer }
      subject!{ get "/lawyers/profile" }
      it { expect(response).to be_success }
    end

    context "not login" do
      subject!{ get "/lawyers/profile" }
      it { expect(response).to redirect_to("/lawyers/sign_in") }
    end
  end

  describe "#edit_profile" do
    before { signin_lawyer }
    subject!{ get "/lawyers/edit-profile" }
    it { expect(response).to be_success }
  end

  describe "#update_profile" do
    before { signin_lawyer }
    subject!{ post "/lawyers/update_profile", lawyer: { current: "律師事務所" } }
    it { expect(response).to redirect_to("/lawyers/profile") }
  end
  
end
