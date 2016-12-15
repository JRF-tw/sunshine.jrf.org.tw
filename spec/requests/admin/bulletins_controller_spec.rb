require 'rails_helper'

RSpec.describe Admin::BulletinsController do
  before { signin_user }

  describe 'already had a bulletin' do
    let(:bulletin) { create :bulletin }

    it 'GET /admin/bulletins' do
      get '/admin/bulletins'
      expect(response).to be_success
    end

    it 'GET /admin/bulletins/new' do
      get '/admin/bulletins/new'
      expect(response).to be_success
    end

    it 'GET /admin/bulletins/123/edit' do
      get "/admin/bulletins/#{bulletin.id}/edit"
      expect(response).to be_success
    end

    it 'PUT /admin/bulletins/123' do
      expect {
        put "/admin/bulletins/#{bulletin.id}", admin_bulletin: { title: 'yes I do' }
      }.to change { bulletin.reload.title }
      expect(response).to be_redirect
    end

    it 'DELETE /admin/bulletins/123' do
      delete "/admin/bulletins/#{bulletin.id}"
      expect(Bulletin.count).to be_zero
    end
  end

  it 'POST /admin/bulletins' do
    expect {
      post '/admin/bulletins', admin_bulletin: attributes_for(:bulletin)
    }.to change { Bulletin.count }.by(1)
    expect(response).to be_redirect
  end
end
