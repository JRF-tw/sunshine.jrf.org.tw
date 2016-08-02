require "rails_helper"

RSpec.describe Parties::AppealsController, type: :request do
  before { signin_party }
  describe "#new" do
    before { get "/party/appeal/new" }
    it { expect(response).to be_success }
  end
end
