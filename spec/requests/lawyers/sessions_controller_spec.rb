require 'rails_helper'

RSpec.describe Lawyers::SessionsController, type: :request do

  describe "#create" do
    let!(:lawyer) { FactoryGirl.create :lawyer, :with_password_and_confirmed, password: "00000000" }

    context "need update profile" do
      subject! { post "/lawyers/sign_in",  lawyer: { email: lawyer.email, password: "00000000" } }

      it { expect(response.body).to redirect_to("/lawyers/edit-profile") }
    end

    context "profile ok" do
      before { lawyer.update_attributes(current: "律師事務所") }
      subject! { post "/lawyers/sign_in",  lawyer: { email: lawyer.email, password: "00000000" } }

      it { expect(response).to redirect_to("/lawyers/profile") }
    end
  end

  describe "#destroy" do
    context "redirect sign_in" do
      before { signin_lawyer }
      subject! { delete "/lawyers/sign_out" }
      it { expect(response).to redirect_to("/lawyers/sign_in") }
    end
  end

end
