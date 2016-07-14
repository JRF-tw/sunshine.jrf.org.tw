require "rails_helper"

RSpec.describe Lawyers::SchedulesController, type: :request do
  before { signin_lawyer }

  describe "#new" do
    subject! { get "/lawyer/score/schedules/new" }
    it { expect(response).to be_success }
  end

  describe "#rule" do
    subject! { get "/lawyer/score/schedules/rule" }
    it { expect(response).to be_success }
  end
end
