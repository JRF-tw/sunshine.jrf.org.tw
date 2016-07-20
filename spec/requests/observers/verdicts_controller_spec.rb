require "rails_helper"

RSpec.describe Observers::VerdictsController, type: :request do
  before { signin_court_observer }

  describe "#new" do
    subject! { get "/observer/score/verdicts/new" }
    it { expect(response.status).to eq(404) }
  end

  describe "#rule" do
    subject! { get "/observer/score/verdicts/rule" }
    it { expect(response).to be_success }
  end

  describe "#verify" do
    subject! { post "/observer/score/verdicts/verify" }
    it { expect(response).to be_redirect }
  end
end
