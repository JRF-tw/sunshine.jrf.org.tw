require "rails_helper"

RSpec.describe Parties::VerdictsController, type: :request do
  before { signin_party }

  describe "#new" do
    subject! { get "/party/score/verdicts/new" }
    it { expect(response).to be_success }
  end

  describe "#rule" do
    subject! { get "/party/score/verdicts/rule" }
    it { expect(response).to be_success }
  end

  describe "#verify" do
    subject! { post "/party/score/verdicts/verify" }
    it { expect(response).to be_redirect }
  end
end
