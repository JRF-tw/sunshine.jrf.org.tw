require 'rails_helper'

RSpec.describe Admin::AwardsController do
  let!(:judge) { create :judge }

  before { signin_user }

  describe 'already had a award' do
    let!(:award) { create :award, owner: judge }

    it 'GET /admin/judges/judge.id/awards' do
      get "/admin/judges/#{judge.id}/awards"
      expect(response).to be_success
    end

    it 'GET /admin/judges/judge.id/awards/new' do
      get "/admin/judges/#{judge.id}/awards/new"
      expect(response).to be_success
    end

    it 'GET /admin/judges/judge.id/awards/123/edit' do
      get "/admin/judges/#{judge.id}/awards/#{award.id}/edit"
      expect(response).to be_success
    end

    it 'PUT /admin/judges/judge.id/awards/123' do
      expect {
        put "/admin/judges/#{judge.id}/awards/#{award.id}", award: { award_type: 'keke' }
      }.to change { award.reload.award_type }.to('keke')
      expect(response).to be_redirect
    end

    it 'DELETE /admin/judges/judge.id/awards/123' do
      delete "/admin/judges/#{judge.id}/awards/#{award.id}"
      expect(Award.count).to be_zero
    end
  end

  it 'POST /admin/judges/judge.id/awards' do
    expect {
      post "/admin/judges/#{judge.id}/awards", award: attributes_for(:award)
    }.to change { Award.count }.by(1)
    expect(response).to be_redirect
  end
end
