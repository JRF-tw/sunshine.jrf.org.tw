require 'rails_helper'

RSpec.describe Lawyer::SessionsController, type: :request do

  describe "#create" do
    let!(:lawyer) { FactoryGirl.create :lawyer, :with_password_and_confirmed, password: "00000000" }

    context "need update profile" do
      subject! { post "/lawyer/sign_in",  lawyer: { email: lawyer.email, password: "00000000" } }

      it { expect(response.body).to redirect_to("/lawyer/profile/edit") }
    end

    context "profile ok" do
      before { lawyer.update_attributes(current: "律師事務所") }
      subject! { post "/lawyer/sign_in",  lawyer: { email: lawyer.email, password: "00000000" } }

      it { expect(response).to redirect_to("/lawyer/profile") }
    end

    context "root should not change" do
      before { signin_lawyer }

      it { expect(get "/").to render_template("base/index") }
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
      before { signin_bystander }
      subject! { delete "/lawyer/sign_out" }

      it { expect(get "/bystanders/edit").to eq(200) }
      it { expect(get "/lawyer/profile").to eq(302) }
    end
  end

end
