require 'rails_helper'

RSpec.describe Admin::ProsecutorsOfficesController do
  before { signin_user }
  let!(:prosecutors_office) { create :prosecutors_office, full_name: '台南第一檢察署', name: '台南地檢署' }

  describe '#index' do
    before { get '/admin/prosecutors_offices' }
    it { expect(response).to be_success }

    context 'search the fullname of prosecutors_office' do
      before { get '/admin/prosecutors_offices', q: { full_name_cont: '台南第一檢察署' } }
      it { expect(response.body).to match(prosecutors_office.full_name) }
    end
  end

  describe '#new' do
    before { get '/admin/prosecutors_offices/new' }
    it { expect(response).to be_success }
  end

  describe '#edit' do
    before { get "/admin/prosecutors_offices/#{prosecutors_office.id}/edit" }
    it { expect(response).to be_success }
  end

  describe '#show' do
    before { get "/admin/prosecutors_offices/#{prosecutors_office.id}" }
    it { expect(response).to be_success }
  end

  describe '#update' do
    subject { put "/admin/prosecutors_offices/#{prosecutors_office.id}", admin_prosecutors_office: { name: 'haha' } }
    it { expect { subject }.to change { prosecutors_office.reload.name }.to('haha') }
    it { expect(response).to be_redirect }
  end

  describe '#delete' do
    it { expect { delete "/admin/prosecutors_offices/#{prosecutors_office.id}" }.to change { ProsecutorsOffice.count }.by(-1) }
  end

  describe '#create' do
    subject { post '/admin/prosecutors_offices', admin_prosecutors_office: attributes_for(:prosecutors_office_for_params) }
    it { expect { subject }.to change { ProsecutorsOffice.count }.by(1) }
    it { expect(response).to be_redirect }
  end
end
