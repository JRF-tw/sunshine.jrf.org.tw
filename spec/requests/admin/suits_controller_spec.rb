require 'rails_helper'

RSpec.describe Admin::SuitsController do
  before { signin_user }

  describe 'already had a suit' do
    let(:suit) { create :suit }

    it 'GET /admin/suits' do
      get '/admin/suits'
      expect(response).to be_success
    end

    it 'GET /admin/suits/123' do
      get "/admin/suits/#{suit.id}"
      expect(response).to be_success
    end

    it 'GET /admin/suits/new' do
      get '/admin/suits/new'
      expect(response).to be_success
    end

    it 'GET /admin/suits/123/edit' do
      get "/admin/suits/#{suit.id}/edit"
      expect(response).to be_success
    end

    it 'PUT /admin/suits/123' do
      expect {
        put "/admin/suits/#{suit.id}", admin_suit: { suit_no: 34_567 }
      }.to change { suit.reload.suit_no }.to(34_567)
      expect(response).to be_redirect
    end

    it 'DELETE /admin/suits/123' do
      delete "/admin/suits/#{suit.id}"
      expect(Suit.count).to be_zero
    end

    it 'before_save :check_procedure_count' do
      put "/admin/suits/#{suit.id}", admin_suit: { is_hidden: false }
      expect(suit.reload.is_hidden).to be_truthy
      create :procedure, suit: suit
      expect {
        put "/admin/suits/#{suit.id}", admin_suit: { is_hidden: false }
      }.to change { suit.reload.is_hidden }.to(false)
    end
  end

  it 'POST /admin/suits' do
    expect {
      post '/admin/suits', admin_suit: attributes_for(:suit)
    }.to change { Suit.count }.by(1)
    expect(response).to be_redirect
  end
end
