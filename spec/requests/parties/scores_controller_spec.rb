require "rails_helper"

RSpec.describe Parties::ScoresController, type: :request do
  before { signin_party }

  describe "#chose_type" do
    subject! { get "/party/score/chose-type" }
    it { expect(response).to be_success }
  end
end
