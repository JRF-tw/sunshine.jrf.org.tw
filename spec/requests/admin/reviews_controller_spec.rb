require "rails_helper"

RSpec.describe Admin::ReviewsController do
  let!(:profile) { create :profile }

  before { signin_user }

  describe "already had a review" do
    let!(:review) { create :review, profile: profile }

    it "GET /admin/profiles/profile.id/reviews" do
      get "/admin/profiles/#{profile.id}/reviews"
      expect(response).to be_success
    end

    it "GET /admin/profiles/profile.id/reviews/new" do
      get "/admin/profiles/#{profile.id}/reviews/new"
      expect(response).to be_success
    end

    it "GET /admin/profiles/profile.id/reviews/123/edit" do
      get "/admin/profiles/#{profile.id}/reviews/#{review.id}/edit"
      expect(response).to be_success
    end

    it "PUT /admin/profiles/profile.id/reviews/123" do
      expect {
        put "/admin/profiles/#{profile.id}/reviews/#{review.id}", admin_review: { name: "haha" }
      }.to change { review.reload.name }.to("haha")
      expect(response).to be_redirect
    end

    it "DELETE /admin/profiles/profile.id/reviews/123" do
      delete "/admin/profiles/#{profile.id}/reviews/#{review.id}"
      expect(Review.count).to be_zero
    end
  end

  it "POST /admin/profiles/profile.id/reviews" do
    expect {
      post "/admin/profiles/#{profile.id}/reviews", admin_review: FactoryGirl.attributes_for(:review)
    }.to change { Review.count }.by(1)
    expect(response).to be_redirect
  end
end
