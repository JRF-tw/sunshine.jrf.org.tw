require 'rails_helper'

RSpec.describe Admin::AwardsController do
  let!(:profile) { create :profile }

  before { signin_user }

  describe 'already had a award' do
    let!(:award) { create :award, profile: profile }

    it 'GET /admin/profiles/profile.id/awards' do
      get "/admin/profiles/#{profile.id}/awards"
      expect(response).to be_success
    end

    it 'GET /admin/profiles/profile.id/awards/new' do
      get "/admin/profiles/#{profile.id}/awards/new"
      expect(response).to be_success
    end

    it 'GET /admin/profiles/profile.id/awards/123/edit' do
      get "/admin/profiles/#{profile.id}/awards/#{award.id}/edit"
      expect(response).to be_success
    end

    it 'PUT /admin/profiles/profile.id/awards/123' do
      expect {
        put "/admin/profiles/#{profile.id}/awards/#{award.id}", admin_award: { award_type: 'keke' }
      }.to change { award.reload.award_type }.to('keke')
      expect(response).to be_redirect
    end

    it 'DELETE /admin/profiles/profile.id/awards/123' do
      delete "/admin/profiles/#{profile.id}/awards/#{award.id}"
      expect(Award.count).to be_zero
    end
  end

  it 'POST /admin/profiles/profile.id/awards' do
    expect {
      post "/admin/profiles/#{profile.id}/awards", admin_award: attributes_for(:award)
    }.to change { Award.count }.by(1)
    expect(response).to be_redirect
  end
end
