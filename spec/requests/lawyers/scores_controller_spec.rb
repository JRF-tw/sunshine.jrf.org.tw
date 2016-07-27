require "rails_helper"

RSpec.describe Lawyers::ScoresController, type: :request do
  before { signin_lawyer }

  describe "#chose_type" do
    subject! { get "/lawyer/score/chose-type" }
    it { expect(response).to be_success }
  end
end
