require "rails_helper"

RSpec.describe Lawyer::SchedulesController, type: :request do
  before { signin_lawyer }

  describe "#new" do
    subject! { get "/lawyer/score/schedules/new" }
    it { expect(response).to be_success }
  end

  describe "#verify" do
    subject! { post "/lawyer/score/schedules/verify" }
    it { expect(response).to be_redirect }
  end
end
