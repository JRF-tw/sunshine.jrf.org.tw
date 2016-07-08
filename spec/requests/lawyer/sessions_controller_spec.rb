require "rails_helper"

RSpec.describe Lawyer::SessionsController, type: :request do

  describe "#create" do
    let!(:lawyer) { FactoryGirl.create :lawyer, :with_password, :with_confirmed, password: "00000000" }

    context "need update profile" do
      before { lawyer.update_attributes(phone_number: nil) }
      subject! { post "/lawyer/sign_in", lawyer: { email: lawyer.email, password: "00000000" } }

      it { expect(response.body).to redirect_to("/lawyer/profile/edit") }
    end

    context "profile ok" do
      before { lawyer.update_attributes(current: "律師事務所") }
      subject! { post "/lawyer/sign_in", lawyer: { email: lawyer.email, password: "00000000" } }

      it { expect(response).to redirect_to("/lawyer") }
    end
  end

  describe "#destroy" do
    context "redirect sign_in" do
      before { signin_lawyer }
      subject! { delete "/lawyer/sign_out" }
      it { expect(response).to redirect_to("/lawyer/sign_in") }
    end

    context "only sign out lawyer" do
      before { signin_lawyer }
      before { signin_court_observer }
      subject! { delete "/lawyer/sign_out" }

      it { expect(get("/observer/edit")).to eq(200) }
      it { expect(get("/lawyer/profile")).to eq(302) }
    end
  end

end
