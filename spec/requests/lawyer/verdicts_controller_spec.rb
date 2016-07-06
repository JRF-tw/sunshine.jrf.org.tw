require "rails_helper"

RSpec.describe Lawyer::VerdictsController, type: :request do
  before { signin_lawyer }

  describe "#new" do
    subject! { get "/lawyer/score/verdicts/new" }
    it { expect(response).to be_success }
  end

  describe "#verify" do
    subject! { post "/lawyer/score/verdicts/verify" }
    it { expect(response).to be_redirect }
  end
end
