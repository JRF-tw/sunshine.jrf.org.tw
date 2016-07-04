require "rails_helper"

RSpec.describe Lawyer::RegistrationsController, type: :request do

  describe "create" do
    context "success" do
      let!(:lawyer) { FactoryGirl.create :lawyer }
      before { post "/lawyer",  lawyer: { name: lawyer.name, email: lawyer.email } }
      it { expect(response).to redirect_to("/lawyer/sign_in") }
    end

    context "lawyer not found" do
      let!(:lawyer) { FactoryGirl.create :lawyer }
      before { post "/lawyer",  lawyer: { name: "先生", email: "1234@example.com" } }

      it { expect(subject).to redirect_to("/lawyer/sign_up") }
    end

    context "empty params" do
      let!(:lawyer) { FactoryGirl.create :lawyer }
      before { post "/lawyer",  lawyer: { name: "", email: "" } }

      it { expect(subject).to redirect_to("/lawyer/sign_up") }
    end

    context "lawyer already active" do
      let!(:lawyer) { FactoryGirl.create :lawyer, :with_password_and_confirmed }
      before { post "/lawyer",  lawyer: { name: lawyer.name, email: lawyer.email } }

      it { expect(response).to redirect_to("/lawyer/sign_in") }
    end
  end

end
