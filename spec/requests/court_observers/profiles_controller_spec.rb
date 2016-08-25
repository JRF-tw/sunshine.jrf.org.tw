require "rails_helper"

RSpec.describe CourtObservers::ProfilesController, type: :request do
  before { signin_court_observer }

  describe "#show" do
    subject! { get "/observer/profile" }
    it { expect(response).to be_success }
  end

  describe "#edit" do
    subject! { get "/observer/profile/edit" }
    it { expect(response).to be_success }
  end

  describe "#update" do
    subject! { put "/observer/profile", court_observer: { phone_number: "0922222222" } }
    it { expect(response).to redirect_to("/observer/profile") }
  end
end
