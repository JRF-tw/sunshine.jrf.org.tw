require 'rails_helper'

RSpec.describe Admin::PunishmentsController do
  let!(:prosecutor) { create :prosecutor }

  before { signin_user }

  describe 'already had a punishment' do
    let!(:punishment) { create :punishment, owner: prosecutor }

    it 'GET /admin/prosecutors/prosecutor.id/punishments' do
      get "/admin/prosecutors/#{prosecutor.id}/punishments"
      expect(response).to be_success
    end

    it 'GET /admin/prosecutors/prosecutor.id/punishments/new' do
      get "/admin/prosecutors/#{prosecutor.id}/punishments/new"
      expect(response).to be_success
    end

    it 'GET /admin/prosecutors/prosecutor.id/punishments/123/edit' do
      get "/admin/prosecutors/#{prosecutor.id}/punishments/#{punishment.id}/edit"
      expect(response).to be_success
    end

    it 'PUT /admin/prosecutors/prosecutor.id/punishments/123' do
      expect {
        put "/admin/prosecutors/#{prosecutor.id}/punishments/#{punishment.id}", punishment: { punish_type: 'haha' }
      }.to change { punishment.reload.punish_type }.to('haha')
      expect(response).to be_redirect
    end

    it 'DELETE /admin/prosecutors/prosecutor.id/punishments/123' do
      delete "/admin/prosecutors/#{prosecutor.id}/punishments/#{punishment.id}"
      expect(Punishment.count).to be_zero
    end
  end

  it 'POST /admin/prosecutors/prosecutor.id/punishments' do
    expect {
      post "/admin/prosecutors/#{prosecutor.id}/punishments", punishment: attributes_for(:punishment)
    }.to change { Punishment.count }.by(1)
    expect(response).to be_redirect
  end
end
