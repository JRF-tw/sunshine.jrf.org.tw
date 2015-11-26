require 'rails_helper'

RSpec.describe ReviewsController, :type => :request do
  let!(:profile){ FactoryGirl.create :profile }
  let!(:review){ FactoryGirl.create :review, profile: profile }
  
  # it "GET /profiles/profile.id/reviews" do
  #   get "/profiles/#{profile.id}/reviews"
  #   expect(response).to be_success
  # end
end
