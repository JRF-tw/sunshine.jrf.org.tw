require 'rails_helper'

RSpec.describe Admin::LicensesController do
  let!(:prosecutor) { create :admin_prosecutor }

  before { signin_user }

  describe 'already had a license' do
    let!(:license) { create :license, owner: prosecutor }

    it 'GET /admin/prosecutors/prosecutor.id/licenses' do
      get "/admin/prosecutors/#{prosecutor.id}/licenses"
      expect(response).to be_success
    end

    it 'GET /admin/prosecutors/prosecutor.id/licenses/new' do
      get "/admin/prosecutors/#{prosecutor.id}/licenses/new"
      expect(response).to be_success
    end

    it 'GET /admin/prosecutors/prosecutor.id/licenses/123/edit' do
      get "/admin/prosecutors/#{prosecutor.id}/licenses/#{license.id}/edit"
      expect(response).to be_success
    end

    it 'PUT /admin/prosecutors/prosecutor.id/licenses/123' do
      expect {
        put "/admin/prosecutors/#{prosecutor.id}/licenses/#{license.id}", license: { license_type: 'keke' }
      }.to change { license.reload.license_type }.to('keke')
      expect(response).to be_redirect
    end

    it 'DELETE /admin/prosecutors/prosecutor.id/licenses/123' do
      delete "/admin/prosecutors/#{prosecutor.id}/licenses/#{license.id}"
      expect(License.count).to be_zero
    end
  end

  it 'POST /admin/prosecutors/prosecutor.id/licenses' do
    expect {
      post "/admin/prosecutors/#{prosecutor.id}/licenses", license: attributes_for(:license)
    }.to change { License.count }.by(1)
    expect(response).to be_redirect
  end
end
