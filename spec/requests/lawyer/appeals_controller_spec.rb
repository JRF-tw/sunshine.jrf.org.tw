require 'rails_helper'

RSpec.describe Lawyer::AppealsController, type: :request do
  before { signin_lawyer }
  describe "#new" do
    before { get "/lawyer/appeal/new" }
    it { expect(response).to be_success }
  end
end
