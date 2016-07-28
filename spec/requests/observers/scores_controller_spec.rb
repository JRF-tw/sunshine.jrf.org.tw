require "rails_helper"

RSpec.describe Observers::ScoresController, type: :request do
  before { signin_court_observer }

  describe "#chose_type" do
    subject! { get "/observer/score/chose-type" }
    it { expect(response).to be_success }
  end
end
