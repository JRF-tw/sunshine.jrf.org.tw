require 'rails_helper'

RSpec.describe Party::VerdictsController, type: :request do
  before { signin_bystander }

  describe "#new" do
    subject!{ get "/bystander/score/verdicts/new" }
    it { expect(response).to be_success }
  end

  describe "#verify" do
    subject!{ post "/bystander/score/verdicts/verify" }
    it { expect(response).to be_redirect }
  end
end
