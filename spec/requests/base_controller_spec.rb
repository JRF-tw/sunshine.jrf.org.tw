require "rails_helper"

RSpec.describe BaseController, type: :request do
  it "GET /" do
    get "/"
    expect(response).to be_success
    expect(response_meta_title).to be_present
  end

  describe "#who_are_you" do
    before { get "/who-are-you" }
    it { expect(response).to be_success }
  end

  it "GET /robots.txt" do
    get "/robots.txt"
    expect(response).to be_success
    expect(response.body).not_to match("<html")
    expect {
      get "/robots"
    }.to raise_error(ActionController::RoutingError)
  end
end
