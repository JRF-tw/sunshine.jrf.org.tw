require "rails_helper"

RSpec.describe Observer::SchedulesController, type: :request do

  before { signin_court_observer }

  describe "#new" do
    subject! { get "/observer/score/schedules/new" }
    it { expect(response).to be_success }
  end

  describe "#verify" do
    subject! { post "/observer/score/schedules/verify" }
    it { expect(response).to be_redirect }
  end
end
