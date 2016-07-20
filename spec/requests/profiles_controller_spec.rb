require "rails_helper"

RSpec.describe ProfilesController, type: :request do
  let!(:profile) { create :profile }

  it "GET /profiles" do
    get "/profiles"
    expect(response).to be_success
  end

  it "GET /profiles/profile.id" do
    get "/profiles/#{profile.id}"
    expect(response).to be_success
  end
end
