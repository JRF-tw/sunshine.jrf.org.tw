require "rails_helper"

RSpec.describe AwardsController, type: :request do
  let!(:profile) { create :profile }
  let!(:award) { create :award, profile: profile }

  it "GET /profiles/profile.id/awards" do
    get "/profiles/#{profile.id}/awards"
    expect(response).to be_success
  end
end
