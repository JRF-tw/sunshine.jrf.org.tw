require "rails_helper"

RSpec.describe ReviewsController, type: :request do
  let!(:profile) { create :profile }
  let!(:review) { create :review, profile: profile }

  # it "GET /profiles/profile.id/reviews" do
  #   get "/profiles/#{profile.id}/reviews"
  #   expect(response).to be_success
  # end
end
