require "rails_helper"

RSpec.describe Api::CourtsController, type: :request do

  describe "#index" do
    subject! { get "/api/courts.json" }
    it { expect(response).to be_success }
  end

end
