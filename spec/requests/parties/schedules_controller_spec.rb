require "rails_helper"

RSpec.describe Parties::SchedulesController, type: :request do
  before { signin_party }

  describe "#new" do
    subject! { get "/party/score/schedules/new" }
    it { expect(response).to be_success }
  end

  describe "#rule" do
    subject! { get "/party/score/schedules/rule" }
    it { expect(response).to be_success }
  end

  describe "#verify" do
    subject! { post "/party/score/schedules/verify" }
    it { expect(response).to be_redirect }
  end
end
