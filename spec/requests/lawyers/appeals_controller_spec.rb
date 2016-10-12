require "rails_helper"

RSpec.describe Lawyers::AppealsController, type: :request do
  before { signin_lawyer }
  describe "#new" do
    subject! { get "/lawyer/appeal/new" }
    it { expect(response).to be_success }
  end
end
