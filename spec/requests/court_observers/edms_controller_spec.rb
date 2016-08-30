require "rails_helper"

RSpec.describe CourtObservers::EdmsController, type: :request do
  before { signin_court_observer }
  describe "#toggle_scbscribe with js" do
    subject! { post "/observer/edm/toggle_subscribe.js" }
    it { expect(response).to be_success }
  end
end
