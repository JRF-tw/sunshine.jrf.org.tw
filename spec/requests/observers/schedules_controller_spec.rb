require "rails_helper"

RSpec.describe Observers::SchedulesController, type: :request do

  before { signin_court_observer }

  describe "#new" do
    subject! { get "/observer/score/schedules/new" }
    it { expect(response).to be_success }
  end

  describe "#rule" do
    subject! { get "/observer/score/schedules/rule" }
    it { expect(response).to be_success }
  end
end
