require 'rails_helper'

RSpec.describe Admin::CourtsController do
  before { signin_user }

  describe '#index' do
    let!(:court1) { create :court, full_name: '台北第一法院', name: '台北第一' }
    let!(:court2) { create :court, full_name: '台南第一法院', name: '台北第一' }

    context 'search the fullname of courts' do
      before { get '/admin/courts', q: { full_name_cont: '台南第一法院' } }
      it {
        expect(response.body).to match(court2.full_name)
        expect(assigns(:courts).first.id).to eq court2.id
      }
    end
  end

  describe 'already had a court' do
    let!(:court) { create :court }

    it 'GET /admin/courts' do
      get '/admin/courts'
      expect(response).to be_success
    end

    it 'GET /admin/courts/new' do
      get '/admin/courts/new'
      expect(response).to be_success
    end

    it 'GET /admin/courts/123/edit' do
      get "/admin/courts/#{court.id}/edit"
      expect(response).to be_success
    end

    context '#show' do
      before { get "/admin/courts/#{court.id}" }
      it { expect(response).to be_success }
    end

    context '#update' do
      subject { put "/admin/courts/#{court.id}", admin_court: { name: 'haha' } }
      it { expect { subject }.to change { court.reload.name }.to('haha') }
      it { expect(response).to be_redirect }
    end

    context '#delete' do
      it { expect { delete "/admin/courts/#{court.id}" }.to change { Court.count }.by(-1) }
    end
  end

  describe '#create' do
    subject { post '/admin/courts', admin_court: attributes_for(:court) }
    it { expect { subject }.to change { Court.count }.by(1) }
    it { expect(response).to be_redirect }
  end

  describe '#edit_weight' do
    subject! { get '/admin/courts/edit_weight' }
    it { expect(response).to be_success }
  end

  describe '#update_weight' do
    let!(:court1) { create :court, is_hidden: false }
    let!(:court2) { create :court, is_hidden: false }
    before { court1.insert_at(1) }
    before { court2.insert_at(2) }
    subject! { put "/admin/courts/#{court2.id}/update_weight.js", admin_court: { weight: 'up' } }
    it { expect(response).to be_success }
    it { expect(court2.reload.weight).to eq(1) }
  end
end
