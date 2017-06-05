require 'rails_helper'

RSpec.describe Admin::ReviewsController do
  let!(:prosecutor) { create :prosecutor }

  before { signin_user }

  describe 'already had a review' do
    let!(:review) { create :review, owner: prosecutor }

    it 'GET /admin/prosecutors/prosecutor.id/reviews' do
      get "/admin/prosecutors/#{prosecutor.id}/reviews"
      expect(response).to be_success
    end

    it 'GET /admin/prosecutors/prosecutor.id/reviews/new' do
      get "/admin/prosecutors/#{prosecutor.id}/reviews/new"
      expect(response).to be_success
    end

    it 'GET /admin/prosecutors/prosecutor.id/reviews/123/edit' do
      get "/admin/prosecutors/#{prosecutor.id}/reviews/#{review.id}/edit"
      expect(response).to be_success
    end

    it 'PUT /admin/prosecutors/prosecutor.id/reviews/123' do
      expect {
        put "/admin/prosecutors/#{prosecutor.id}/reviews/#{review.id}", review: { name: 'haha' }
      }.to change { review.reload.name }.to('haha')
      expect(response).to be_redirect
    end

    it 'DELETE /admin/prosecutors/prosecutor.id/reviews/123' do
      delete "/admin/prosecutors/#{prosecutor.id}/reviews/#{review.id}"
      expect(Review.count).to be_zero
    end
  end

  it 'POST /admin/prosecutors/prosecutor.id/reviews' do
    expect {
      post "/admin/prosecutors/#{prosecutor.id}/reviews", review: attributes_for(:review)
    }.to change { Review.count }.by(1)
    expect(response).to be_redirect
  end
end
