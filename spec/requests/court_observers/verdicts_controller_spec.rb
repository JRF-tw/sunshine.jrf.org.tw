require "rails_helper"

RSpec.describe CourtObservers::VerdictsController, type: :request do
  before { signin_court_observer }

  describe "#new" do
    subject! { get "/observer/score/verdicts/new" }
    it { expect(response.status).to eq(404) }
  end
end
